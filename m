Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41A633395
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Nov 2022 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKVCxK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Nov 2022 21:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKVCxJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Nov 2022 21:53:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AD0BC1A;
        Mon, 21 Nov 2022 18:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669085588; x=1700621588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+VC1VIkqZnYaq7sS4BBc9RSxml4bc5J1RXDygS8KJ/I=;
  b=XifBk4rO2U9EHBA2QA2uu25qZjvGuiZE3q0enWz+psvEbd3ZYMYblMR0
   6b2/xcbU8+tFmJAAw95ktn+HcgmbT12SmWJwJLpue6tJQCdbXkol3E3YY
   ERJTQMAgM1GmSVxCpd+1+zl8MQ55t7IyTNShqPw62UcfBumsGDCOHB9rT
   inPCx8Ucr14tj7TAJ4mfGhtiR3fUUfG+4BHWdfqI+zD7e1gOmqqGu0QiF
   /ErtKQ26wxb0fBeSY7Ue3DGmVnwNYNQNITC1peVdzeO2AJrdCdVReVSWD
   phoy/FMRkKrZeHTBreCSmyz1SrSNSh3+y/5NXO+A8J1Ki8+4v1nF5dbup
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="400003146"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="400003146"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 18:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="591989980"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="591989980"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2022 18:53:03 -0800
Date:   Tue, 22 Nov 2022 10:43:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] intel-m10-bmc: Split BMC to core and SPI parts
 & add PMCI+N6000 support
Message-ID: <Y3w3VLvjth4peSPd@yilunxu-OptiPlex-7050>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-17 at 14:05:04 +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> Here are the patches for MAX 10 BMC core/SPI interface split and
> addition of the PMCI interface. There are a few supporting rearrangement
> patches prior to the actual split. This series also introduced regmap for
> indirect register access generic to Intel FPGA IPs.
> 
> The current downside of the split is that there's not that much code
> remaining in the core part when all the type specific definitions are
> moved to the file with the relevant interface.
> 
> I'm not entirely sure if I did properly address Yilun's comment on
> placement of the flash_ops related code. To me the original way which
> keeps them in mfd/intel-m10-bmc-{spi,pmci}.c still seems to the best
> way. If that is still not acceptable, I propose that I'll move just the
> flash ops functions into intel-m10-bmc-sec-update-{spi,pmci}.c and

I don't think the split of intel-m10-bmc-sec-update-{spi, pmci}.c is
needed. The mfd subdev is a platform device actually, it doesn't have to
know the bus type.

> create sec related platform info struct to select the correct flash
> ops. This would effectively be the "double split" approach I suggested
> earlier (both mfd and sec have their own per interface splits, to me
> the double split looks overkill but it would meet Yilun's goal of
> keeping sec related code within the sec driver).

Yes, this is still my preference.

My idea is, the secure update driver could be told by mfd core whether
there is a bypass channel for flash bulk read/write. If yes, use it. If
no, just direct access to flash staging areas as it previously does.

This is like:

struct intel_m10bmc {
        struct device *dev;
        struct regmap *regmap;
	...
+       const struct intel_m10bmc_flash_bulk_ops *flash_bulk_ops;
}

In intel-m10-bmc-pmci.c,

  +static const struct intel_m10bmc_flash_bulk_ops m10bmc_pmci_flash_bulk_ops = {
  +       .read = m10bmc_pmci_flash_bulk_read,
  +       .write = m10bmc_pmci_flash_bulk_write,
  };

In intel-m10-bmc-spi.c, no need to have flash_bulk_ops. 

In intel-m10-bmc-sec-update.c,

  Check if flash_bulk_ops is available, if yes,

    set_flash_host_mux(aquire)   /* I assume flash mux is dedicated for sec-update dev */
    sec->m10bmc->flash_bulk_ops->write()
    set_flash_host_mux(release)

  if no:
    follow previous direct access.

Thanks,
Yilun

> 
> The patch set is based on top of commit dfd10332596e ("fpga:
> m10bmc-sec: Fix kconfig dependencies") to avoid triggering a Kconfig
> conflict.
> 
> v2:
> - Drop type from mfd side, the platform info takes care of differentation
> - Explain introducing ->info to struct m10bmc in commit message (belongs logically there)
> - Intro PMCI better
> - Improve naming
>         - Rename M10BMC_PMCI_FLASH_CTRL to M10BMC_PMCI_FLASH_MUX_CTRL
>         - Use m10bmc_pmci/M10BMC_PMCI prefix consistently
>         - Use M10BMC_SPI prefix for SPI related defines
>         - Newly added stuff gets m10bmc_spi prefix
> - Removed dev from struct m10bmc_pmci_device
> - Rename "n_offset" variable to "offset" in PMCI flash ops
> - Always issue idle command in regmap indirect to clear RD/WR/ACK bits
> - Handle stride misaligned sizes in flash read/write ops
> 
> Ilpo Järvinen (11):
>   mfd: intel-m10-bmc: Create m10bmc_platform_info for type specific info
>   mfd: intel-m10-bmc: Rename the local variables
>   mfd: intel-m10-bmc: Split into core and spi specific parts
>   mfd: intel-m10-bmc: Support multiple CSR register layouts
>   fpga: intel-m10-bmc: Add flash ops for sec update
>   mfd: intel-m10-bmc: Downscope SPI defines & prefix with M10BMC_SPI
>   regmap: indirect: Add indirect regmap support
>   intel-m10-bmc: Add regmap_indirect_cfg for Intel FPGA IPs
>   mfd: intel-m10-bmc: Add PMCI driver
>   fpga: m10bmc-sec: Add support for N6000
>   mfd: intel-m10-bmc: Change MODULE_LICENSE() to GPL
> 
>  .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
>  MAINTAINERS                                   |   2 +-
>  drivers/base/regmap/Kconfig                   |   3 +
>  drivers/base/regmap/Makefile                  |   1 +
>  drivers/base/regmap/regmap-indirect.c         | 128 +++++++
>  drivers/fpga/Kconfig                          |   2 +-
>  drivers/fpga/intel-m10-bmc-sec-update.c       | 149 ++++----
>  drivers/hwmon/Kconfig                         |   2 +-
>  drivers/mfd/Kconfig                           |  34 +-
>  drivers/mfd/Makefile                          |   6 +-
>  drivers/mfd/intel-m10-bmc-core.c              | 133 +++++++
>  drivers/mfd/intel-m10-bmc-pmci.c              | 361 ++++++++++++++++++
>  drivers/mfd/intel-m10-bmc-spi.c               | 270 +++++++++++++
>  drivers/mfd/intel-m10-bmc.c                   | 238 ------------
>  include/linux/mfd/intel-m10-bmc.h             | 122 +++---
>  include/linux/regmap.h                        |  55 +++
>  16 files changed, 1131 insertions(+), 383 deletions(-)
>  create mode 100644 drivers/base/regmap/regmap-indirect.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-core.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
>  create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
>  delete mode 100644 drivers/mfd/intel-m10-bmc.c
> 
> -- 
> 2.30.2
> 
