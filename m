Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD72A5415A5
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 22:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357539AbiFGUfZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jun 2022 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359478AbiFGU2v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jun 2022 16:28:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62801DE2F4;
        Tue,  7 Jun 2022 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654626850; x=1686162850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1D466g61S0JdOyvdeNI5Kb/2JvASwpfM/61n6c471g=;
  b=Abrsy2FTdlWVZGxSFHBBaViyTOBrPa7mtJ9y2OUwXaF33DAVzFtC+aWS
   agFalCePq6TYMTZpZX6Zd4B/J9iYdNAnRJX5qnGp2AZw8C8zBApy4wijL
   jZayafI13cGzviOLWxo0RyQWvqRrWxLubsA78DVb3JobE80uqmGbKHFlT
   UKF8Nu1pVMN6E7LW5IZ5nRDQhRlihkEkUAdQfGkhNuD+lYpaS8bmNXjQs
   VR15UgpfNuEHywc5ls0XGatINDBNVXKP7Nr0EwY1CR0xoagMS7qOt72ej
   nAFlWcXPvgDbPmZ3w8gQ37wQ/jjUuZKBWQKZRhSR8EyKf3u/A6sRABC6M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="363078203"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="363078203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 11:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636265428"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2022 11:34:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nye1g-000Dr3-MA;
        Tue, 07 Jun 2022 18:34:00 +0000
Date:   Wed, 8 Jun 2022 02:33:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        lee.jones@linaro.org
Cc:     kbuild-all@lists.01.org, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: Re: [PATCH v1 3/4] mfd: intel-m10-bmc: add PMCI driver
Message-ID: <202206080218.qhislJf4-lkp@intel.com>
References: <20220607032833.3482-4-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607032833.3482-4-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tianfei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on v5.19-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianfei-Zhang/mfd-add-PMCI-driver-support/20220607-113619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220608/202206080218.qhislJf4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/88995bb5653b69e780baba37b6ade01348054135
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tianfei-Zhang/mfd-add-PMCI-driver-support/20220607-113619
        git checkout 88995bb5653b69e780baba37b6ade01348054135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/mfd/intel-m10-bmc-pmci.c: In function 'pmci_probe':
>> drivers/mfd/intel-m10-bmc-pmci.c:58:17: error: implicit declaration of function 'devm_regmap_init_indirect_register' [-Werror=implicit-function-declaration]
      58 |                 devm_regmap_init_indirect_register(dev,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mfd/intel-m10-bmc-pmci.c:57:29: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      57 |         pmci->m10bmc.regmap =
         |                             ^
   cc1: some warnings being treated as errors


vim +/devm_regmap_init_indirect_register +58 drivers/mfd/intel-m10-bmc-pmci.c

    39	
    40	static int pmci_probe(struct dfl_device *ddev)
    41	{
    42		struct device *dev = &ddev->dev;
    43		struct pmci_device *pmci;
    44	
    45		pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
    46		if (!pmci)
    47			return -ENOMEM;
    48	
    49		pmci->m10bmc.dev = dev;
    50		pmci->dev = dev;
    51		pmci->m10bmc.type = M10_N6000;
    52	
    53		pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
    54		if (IS_ERR(pmci->base))
    55			return PTR_ERR(pmci->base);
    56	
  > 57		pmci->m10bmc.regmap =
  > 58			devm_regmap_init_indirect_register(dev,
    59							   pmci->base + M10BMC_PMCI_INDIRECT_BASE,
    60							   &m10bmc_pmci_regmap_config);
    61		if (IS_ERR(pmci->m10bmc.regmap))
    62			return PTR_ERR(pmci->m10bmc.regmap);
    63	
    64		return m10bmc_dev_init(&pmci->m10bmc);
    65	}
    66	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
