Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330E9543DCB
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiFHUse (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 16:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiFHUsa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 16:48:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04AF136C;
        Wed,  8 Jun 2022 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654721308; x=1686257308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yL3Zv+i95CITTrChFrjzM4m9fnoVpSgmhhjr2XdpLDI=;
  b=U86VLypUnz5rXnbuUUsz6siH+5t3udYNo0xGxFlPAWC29n0xu0oyXn+H
   x5GDKofzo2U3e6a7+uQj9NUZ6U0RfDZ4GGReuE6D9nXqWGEDDRAuQTwT2
   hGI2HeiXeWX7pfXGDwo7lzvwQu5wGRCaWGNf7BrPxtm6i+8Sbn2E7+21M
   PtrL0RxhVbIZ/s2dM6FnbrAN/lY4J8DIDxlqvRvUNjYkEwR2I61IB11Su
   Puhe7pI1kDxQrEZII3ZSkYJ6zUZLAfP/pYb5IQxQEyWUWBYhdYH3+YtQT
   rF9eJw14+DjtVRl5P8R25hkAtjmD8S+MNO0xlrDfWJq8g1znVz1c0ye47
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="275809048"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="275809048"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 13:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="670772436"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 13:48:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz2bJ-000Ezp-1i;
        Wed, 08 Jun 2022 20:48:25 +0000
Date:   Thu, 9 Jun 2022 04:47:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        lee.jones@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, hao.wu@intel.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: Re: [PATCH v1 3/4] mfd: intel-m10-bmc: add PMCI driver
Message-ID: <202206090450.TSpq556V-lkp@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on v5.19-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tianfei-Zhang/mfd-add-PMCI-driver-support/20220607-113619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220609/202206090450.TSpq556V-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/88995bb5653b69e780baba37b6ade01348054135
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tianfei-Zhang/mfd-add-PMCI-driver-support/20220607-113619
        git checkout 88995bb5653b69e780baba37b6ade01348054135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/intel-m10-bmc-core.c:18:34: warning: unused variable 'n6000_fw_handshake_regs' [-Wunused-const-variable]
   static const struct regmap_range n6000_fw_handshake_regs[] = {
                                    ^
   1 warning generated.


vim +/n6000_fw_handshake_regs +18 drivers/mfd/intel-m10-bmc-core.c

    17	
  > 18	static const struct regmap_range n6000_fw_handshake_regs[] = {
    19		regmap_reg_range(M10BMC_PMCI_TELEM_START, M10BMC_PMCI_TELEM_END),
    20	};
    21	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
