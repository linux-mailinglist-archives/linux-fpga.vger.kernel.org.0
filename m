Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02C850EB1A
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiDYVLp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245685AbiDYVLm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 17:11:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFC6D976;
        Mon, 25 Apr 2022 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650920916; x=1682456916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w9h6Cdx4XjslBo66HrakyPOtDRXWJENi2JZ7dmBusrQ=;
  b=WxiLxXoLjnOUypy6ZJghPASHB/D/JGsUdE+mW994LJmgleaZ0DV0SP97
   TNZLIIRMYBdO+owWgjTVBA7ikq2ALPcV/V9jLgY2qE7buxplLmoPVwQ14
   0CMrJXtOHA84Ka1KSxAccosqGFLS8fz8m1LtcqvaW8FtBhCJvMpLQ//Lc
   opg5THyeHyddVhjua25DV+wzfaIF6CGha0QsO2FxZF4MU4eSEm8Xk73Mc
   h8SFVItnO3eQQdjezEbbBGGf46h1cPYRof0/jgqu93azAwLjOpmdYe7UI
   etozUQ0XzfNgRE5PrjHGb6uEQOLV2+gDejN6KKTd4aIYStIvkxQmkwpgp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="262961519"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="262961519"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="564254914"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Apr 2022 14:08:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj5wd-0002sj-V6;
        Mon, 25 Apr 2022 21:08:31 +0000
Date:   Tue, 26 Apr 2022 05:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, trix@redhat.com,
        marpagan@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        tianfei.zhang@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: fix the kernel warning when
 release/assign ports for SRIOV
Message-ID: <202204260456.dOkQIjjg-lkp@intel.com>
References: <20220425174827.89819-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425174827.89819-1-russell.h.weight@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc4 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Russ-Weight/fpga-dfl-fix-the-kernel-warning-when-release-assign-ports-for-SRIOV/20220426-014949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git af2d861d4cd2a4da5137f795ee3509e6f944a25b
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260456.dOkQIjjg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4b4db40cd1b608457d6e1fcf95443bd940d01f3c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Russ-Weight/fpga-dfl-fix-the-kernel-warning-when-release-assign-ports-for-SRIOV/20220426-014949
        git checkout 4b4db40cd1b608457d6e1fcf95443bd940d01f3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/fpga/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/fpga/dfl.c:54: warning: cannot understand function prototype: 'struct dfl_dev_info '
   drivers/fpga/dfl.c:74: warning: cannot understand function prototype: 'struct dfl_chardev_info '
   drivers/fpga/dfl.c:154: warning: Function parameter or member 'fdata' not described in 'dfl_fpga_port_ops_get'
   drivers/fpga/dfl.c:154: warning: Excess function parameter 'pdev' description in 'dfl_fpga_port_ops_get'
   drivers/fpga/dfl.c:220: warning: Function parameter or member 'fdata' not described in 'dfl_fpga_check_port_id'
   drivers/fpga/dfl.c:220: warning: Excess function parameter 'pdev' description in 'dfl_fpga_check_port_id'
   drivers/fpga/dfl.c:716: warning: Function parameter or member 'revision' not described in 'dfl_feature_info'
>> drivers/fpga/dfl.c:1509: warning: expecting prototype for __dfl_fpga_cdev_find_port(). Prototype was for __dfl_fpga_cdev_find_port_data() instead


vim +1509 drivers/fpga/dfl.c

543be3d8c999b3 Wu Hao   2018-06-30  1490  
5d56e117001996 Wu Hao   2018-06-30  1491  /**
5d56e117001996 Wu Hao   2018-06-30  1492   * __dfl_fpga_cdev_find_port - find a port under given container device
5d56e117001996 Wu Hao   2018-06-30  1493   *
5d56e117001996 Wu Hao   2018-06-30  1494   * @cdev: container device
5d56e117001996 Wu Hao   2018-06-30  1495   * @data: data passed to match function
5d56e117001996 Wu Hao   2018-06-30  1496   * @match: match function used to find specific port from the port device list
5d56e117001996 Wu Hao   2018-06-30  1497   *
5d56e117001996 Wu Hao   2018-06-30  1498   * Find a port device under container device. This function needs to be
5d56e117001996 Wu Hao   2018-06-30  1499   * invoked with lock held.
5d56e117001996 Wu Hao   2018-06-30  1500   *
5d56e117001996 Wu Hao   2018-06-30  1501   * Return: pointer to port's platform device if successful, NULL otherwise.
5d56e117001996 Wu Hao   2018-06-30  1502   *
5d56e117001996 Wu Hao   2018-06-30  1503   * NOTE: you will need to drop the device reference with put_device() after use.
5d56e117001996 Wu Hao   2018-06-30  1504   */
4b4db40cd1b608 Xu Yilun 2022-04-25  1505  struct dfl_feature_dev_data *
4b4db40cd1b608 Xu Yilun 2022-04-25  1506  __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
4b4db40cd1b608 Xu Yilun 2022-04-25  1507  			       int (*match)(struct dfl_feature_dev_data *,
4b4db40cd1b608 Xu Yilun 2022-04-25  1508  					    void *))
5d56e117001996 Wu Hao   2018-06-30 @1509  {
4b4db40cd1b608 Xu Yilun 2022-04-25  1510  	struct dfl_feature_dev_data *fdata;
5d56e117001996 Wu Hao   2018-06-30  1511  
4b4db40cd1b608 Xu Yilun 2022-04-25  1512  	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
4b4db40cd1b608 Xu Yilun 2022-04-25  1513  		if (match(fdata, data))
4b4db40cd1b608 Xu Yilun 2022-04-25  1514  			return fdata;
5d56e117001996 Wu Hao   2018-06-30  1515  	}
5d56e117001996 Wu Hao   2018-06-30  1516  
5d56e117001996 Wu Hao   2018-06-30  1517  	return NULL;
5d56e117001996 Wu Hao   2018-06-30  1518  }
4b4db40cd1b608 Xu Yilun 2022-04-25  1519  EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port_data);
5d56e117001996 Wu Hao   2018-06-30  1520  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
