Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204A53FA18
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 11:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiFGJnz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jun 2022 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiFGJny (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jun 2022 05:43:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A97CB5B;
        Tue,  7 Jun 2022 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654595033; x=1686131033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZRgiGkZugXGc7OZ604Zh98ie9xBINJvjuzajnbFDTJA=;
  b=ZVNu+7AqZBcl3bb2nh6FWcES882Fq6/eXyLbthnB1U3vL1cMeKtpFQCv
   rNbJO8iJkPfkOjaX5iyU5NNZrLvbup6aoKR6NemquMy0Lqswmfcq7k7Vo
   KvmLaWJAo/Yj2rjCUmaE1PQmAb02kU2or8twKW3q9shJMFtu1OxpYl0ij
   shgdjPAGEUcu11NCXRyMD23XsqE0RWv6TcBw4ucnzq0so575Jx9Tyk+hb
   tUH7e1efOZyxZALQhdUJ/7Apkj1PX6EOfOeLub9aIC0YyLq9ywLz4EnJm
   lrQ107XWM2cuEYOb8dieb4qcv6BFvlPZVc/5HLE242NID7ZUqSvcKWGXI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274251788"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="274251788"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 02:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="636052874"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2022 02:43:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyVkb-000DYr-Dv;
        Tue, 07 Jun 2022 09:43:49 +0000
Date:   Tue, 7 Jun 2022 17:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        lee.jones@linaro.org
Cc:     kbuild-all@lists.01.org, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: Re: [PATCH v1 3/4] mfd: intel-m10-bmc: add PMCI driver
Message-ID: <202206071758.rNTfUEh0-lkp@intel.com>
References: <20220607032833.3482-4-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607032833.3482-4-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tianfei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianfei-Zhang/mfd-add-PMCI-driver-support/20220607-113619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220607/202206071758.rNTfUEh0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/88995bb5653b69e780baba37b6ade01348054135
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tianfei-Zhang/mfd-add-PMCI-driver-support/20220607-113619
        git checkout 88995bb5653b69e780baba37b6ade01348054135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/intel-m10-bmc-core.c:18:34: warning: 'n6000_fw_handshake_regs' defined but not used [-Wunused-const-variable=]
      18 | static const struct regmap_range n6000_fw_handshake_regs[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~


vim +/n6000_fw_handshake_regs +18 drivers/mfd/intel-m10-bmc-core.c

    17	
  > 18	static const struct regmap_range n6000_fw_handshake_regs[] = {
    19		regmap_reg_range(M10BMC_PMCI_TELEM_START, M10BMC_PMCI_TELEM_END),
    20	};
    21	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
