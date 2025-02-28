import common.Review

def j = new Review
	(
		name: 'MacOS_Integrated',
		libraries: ['MacOS'],
		label: 'MacOS',
		artifacts: 'tmp/*.log',
		allowEmptyArtifacts: true,
		xunit: true
	).generate(this)


j.with
{
	steps
	{
		shell('cd source; cmake -DCMD=IMPORT_PATCH -P cmake/cmd.cmake')

		shell('security unlock-keychain ${KEYCHAIN_CREDENTIALS} ${HOME}/Library/Keychains/login.keychain-db')

		shell('cd source; cmake --preset ci-macos-integrated')

		shell('''\
			export DYLD_FRAMEWORK_PATH=${WORKSPACE}/libs/build/dist/lib
			export DYLD_LIBRARY_PATH=${WORKSPACE}/libs/build/dist/lib
			cmake --build build
			'''.stripIndent().trim())

		shell('''\
			export DYLD_FRAMEWORK_PATH=${WORKSPACE}/libs/build/dist/lib
			export DYLD_LIBRARY_PATH=${WORKSPACE}/libs/build/dist/lib
			export QT_PLUGIN_PATH=${WORKSPACE}/libs/build/dist/plugins
			ctest --test-dir build --output-on-failure
			'''.stripIndent().trim())
	}
}
