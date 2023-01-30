Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3468038F
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Jan 2023 02:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjA3Boc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 Jan 2023 20:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3Bob (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 Jan 2023 20:44:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB51A977;
        Sun, 29 Jan 2023 17:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675043070; x=1706579070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2K4b7bGbKRklP9BOuOl1xdXxItGeJ3QCZn26h699B0A=;
  b=Ft3wi4CDpFznKbhEwX7ZOms+nJGhtSUuJHJ4fmMRXH1Ohhr5FTWfFatt
   MPRwFTNt29u4oWCKcWRgNqHTJmvF4RmZ1Cw0IAMg5EzKAmkg8hrOfARIC
   8gCyT06ToxcCoXSShXYA4QDQRthyqjRNzEU1+Rdk3WWN06gtfNfYzGJuJ
   kWdhk0xA9AcZNfKvWFXg+CHD1S5v5XJUYEWyXG8uIjNLEcvTPduScxs4x
   HPo3WGRlZOHQrpd7NgXdh/n67rTIV2We8BcKf+g4ZH4+1iMclKnknkRbA
   8acnku8SLFnaeTW8ONkSXwm2ntMD2PoMuS8AduTV6H/LCVY8T653MDyOi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="325149331"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="325149331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 17:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="694392676"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="694392676"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2023 17:44:25 -0800
Date:   Mon, 30 Jan 2023 09:33:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, FPGA and HWMON due for
 the v6.3 merge window
Message-ID: <Y9cefQsSi3X5mk8W@yilunxu-OptiPlex-7050>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
 <Y9QFkFF2aZ/GibZt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9QFkFF2aZ/GibZt@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-27 at 17:10:40 +0000, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> 
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-fpga-hwmon-v6.3

I've already pulled it to fpga tree and pushed to Greg as the merge
window is near.

Patch #11 is left. I could make another pull request if it got acked by
Lee soon, or we wait for the next cycle.

Thanks,
Yilun

> 
> for you to fetch changes up to 869b9eddf0b38a22c27a400e2fa849d2ff2aa7e1:
> 
>   mfd: intel-m10-bmc: Add PMCI driver (2023-01-27 10:47:11 +0000)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, FPGA and HWMON due for the v6.3 merge window
> 
> ----------------------------------------------------------------
> Ilpo Järvinen (10):
>       mfd: intel-m10-bmc: Add missing includes to header
>       mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
>       mfd: intel-m10-bmc: Rename the local variables
>       mfd: intel-m10-bmc: Split into core and spi specific parts
>       mfd: intel-m10-bmc: Support multiple CSR register layouts
>       fpga: intel-m10-bmc: Rework flash read/write
>       mfd: intel-m10-bmc: Prefix register defines with M10BMC_N3000
>       fpga: m10bmc-sec: Create helpers for rsu status/progress checks
>       fpga: m10bmc-sec: Make rsu status type specific
>       mfd: intel-m10-bmc: Add PMCI driver
> 
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |   8 +-
>  MAINTAINERS                                        |   2 +-
>  drivers/fpga/Kconfig                               |   2 +-
>  drivers/fpga/intel-m10-bmc-sec-update.c            | 364 +++++++++++++--------
>  drivers/hwmon/Kconfig                              |   2 +-
>  drivers/mfd/Kconfig                                |  32 +-
>  drivers/mfd/Makefile                               |   5 +-
>  drivers/mfd/intel-m10-bmc-core.c                   | 122 +++++++
>  drivers/mfd/intel-m10-bmc-pmci.c                   | 219 +++++++++++++
>  drivers/mfd/intel-m10-bmc-spi.c                    | 168 ++++++++++
>  drivers/mfd/intel-m10-bmc.c                        | 238 --------------
>  include/linux/mfd/intel-m10-bmc.h                  | 154 ++++++---
>  12 files changed, 888 insertions(+), 428 deletions(-)
>  create mode 100644 drivers/mfd/intel-m10-bmc-core.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
>  delete mode 100644 drivers/mfd/intel-m10-bmc.c
> 
> -- 
> Lee Jones [李琼斯]
