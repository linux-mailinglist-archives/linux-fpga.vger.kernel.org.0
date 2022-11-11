Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63C625705
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Nov 2022 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiKKJjS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Nov 2022 04:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiKKJjP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Nov 2022 04:39:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6FE03D;
        Fri, 11 Nov 2022 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668159554; x=1699695554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7OZzuX8TLIQNsGznAUzwYn3l/SUlI1zbPCR2OGLlWao=;
  b=D0hPWBn1z/++BgvyBSldldAa0H9YM5qdRqK5ar5sDS0eGW97zZslYMdP
   HeiREBulYypVCRIPJmw+y3okkfm5Rqa2vs0riJJQXj6pgTAZEeYVECFbW
   qEEBTCrsdDmo366M+R+0Sn6NS9WIA2VyUB57Ctau3tm0WluE8XUD0SGMb
   c3AKHTUlLIBnF70DdG9FUvvzzPoK7KyK+3iIevDYR1KXp2q84iIg60B0z
   zVueSQ9ngYLJwFNCtjbXl8f2wFu2Z5cxcPYi9FPkqxWbuCUF8QKM+8IHy
   df7jfo7KAzgYaEyHY3AqMO5iv12vavkGgFLm3ds2pz1nQiPZWs+KC/7xg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373697762"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="373697762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 01:39:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="762617046"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="762617046"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2022 01:39:11 -0800
Date:   Fri, 11 Nov 2022 17:29:51 +0800
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] mfd: intel-m10-bmc: Downscope SPI related defines
Message-ID: <Y24WDyIPO7NRa8Vg@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108144305.45424-8-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-08 at 16:43:00 +0200, Ilpo Järvinen wrote:
> Move SPI related defines to per interface from the global header. This

These definitions are not for SPI, maybe more precisely like "SPI based
board definitions".

> makes it harder to shoot oneself into foot.

Maybe better to use plain text in commit message.

> 
> Some bitfield defs are also moved to intel-m10-bmc-core which seems
> more appropriate for them.

I'm still not clear about the motivation of these movements. For example:

We move the MAC registers in core, then should we also move sec update
registers in sec update driver?

We move the DOORBELL reg addr out, but keep DOORBELL reg fields in
header file, seems make harder for people to get the whole picture.

Thanks,
Yilun

> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c  | 11 ++++++++
>  drivers/mfd/intel-m10-bmc-spi.c   | 39 +++++++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h | 47 -------------------------------
>  3 files changed, 50 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index 51b78b868235..50a4ec758bdb 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -12,6 +12,17 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  
> +/* Register fields of system registers */
> +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> +#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> +#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> +
>  static ssize_t bmc_version_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> index e3b2edb8bc07..4a7a16d9f8d6 100644
> --- a/drivers/mfd/intel-m10-bmc-spi.c
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -13,6 +13,45 @@
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> +#define M10BMC_LEGACY_BUILD_VER		0x300468
> +#define M10BMC_SYS_BASE			0x300800
> +#define M10BMC_SYS_END			0x300fff
> +#define M10BMC_FLASH_BASE		0x10000000
> +#define M10BMC_FLASH_END		0x1fffffff
> +#define M10BMC_MEM_END			M10BMC_FLASH_END
> +
> +#define M10BMC_STAGING_BASE		0x18000000
> +
> +/* Register offset of system registers */
> +#define NIOS2_FW_VERSION		0x0
> +#define M10BMC_MAC_LOW			0x10
> +#define M10BMC_MAC_HIGH			0x14
> +#define M10BMC_TEST_REG			0x3c
> +#define M10BMC_BUILD_VER		0x68
> +#define M10BMC_VER_LEGACY_INVALID	0xffffffff
> +
> +/* Secure update doorbell register, in system register region */
> +#define M10BMC_DOORBELL			0x400
> +
> +/* Authorization Result register, in system register region */
> +#define M10BMC_AUTH_RESULT		0x404
> +
> +/* Addresses for security related data in FLASH */
> +#define BMC_REH_ADDR	0x17ffc004
> +#define BMC_PROG_ADDR	0x17ffc000
> +#define BMC_PROG_MAGIC	0x5746
> +
> +#define SR_REH_ADDR	0x17ffd004
> +#define SR_PROG_ADDR	0x17ffd000
> +#define SR_PROG_MAGIC	0x5253
> +
> +#define PR_REH_ADDR	0x17ffe004
> +#define PR_PROG_ADDR	0x17ffe000
> +#define PR_PROG_MAGIC	0x5250
> +
> +/* Address of 4KB inverted bit vector containing staging area FLASH count */
> +#define STAGING_FLASH_COUNT	0x17ffb000
> +
>  static const struct regmap_range m10bmc_regmap_range[] = {
>  	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
>  	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 860408aa8db3..ed920f76d3c8 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -15,39 +15,8 @@ enum m10bmc_type {
>  	M10_N5010,
>  };
>  
> -#define M10BMC_LEGACY_BUILD_VER		0x300468
> -#define M10BMC_SYS_BASE			0x300800
> -#define M10BMC_SYS_END			0x300fff
> -#define M10BMC_FLASH_BASE		0x10000000
> -#define M10BMC_FLASH_END		0x1fffffff
> -#define M10BMC_MEM_END			M10BMC_FLASH_END
> -
> -#define M10BMC_STAGING_BASE		0x18000000
>  #define M10BMC_STAGING_SIZE		0x3800000
>  
> -/* Register offset of system registers */
> -#define NIOS2_FW_VERSION		0x0
> -#define M10BMC_MAC_LOW			0x10
> -#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> -#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> -#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> -#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> -#define M10BMC_MAC_HIGH			0x14
> -#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> -#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> -#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> -#define M10BMC_TEST_REG			0x3c
> -#define M10BMC_BUILD_VER		0x68
> -#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> -#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> -#define M10BMC_VER_LEGACY_INVALID	0xffffffff
> -
> -/* Secure update doorbell register, in system register region */
> -#define M10BMC_DOORBELL			0x400
> -
> -/* Authorization Result register, in system register region */
> -#define M10BMC_AUTH_RESULT		0x404
> -
>  /* Doorbell register fields */
>  #define DRBL_RSU_REQUEST		BIT(0)
>  #define DRBL_RSU_PROGRESS		GENMASK(7, 4)
> @@ -108,22 +77,6 @@ enum m10bmc_type {
>  #define RSU_COMPLETE_INTERVAL_MS	1000
>  #define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
>  
> -/* Addresses for security related data in FLASH */
> -#define BMC_REH_ADDR	0x17ffc004
> -#define BMC_PROG_ADDR	0x17ffc000
> -#define BMC_PROG_MAGIC	0x5746
> -
> -#define SR_REH_ADDR	0x17ffd004
> -#define SR_PROG_ADDR	0x17ffd000
> -#define SR_PROG_MAGIC	0x5253
> -
> -#define PR_REH_ADDR	0x17ffe004
> -#define PR_PROG_ADDR	0x17ffe000
> -#define PR_PROG_MAGIC	0x5250
> -
> -/* Address of 4KB inverted bit vector containing staging area FLASH count */
> -#define STAGING_FLASH_COUNT	0x17ffb000
> -
>  /**
>   * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
>   */
> -- 
> 2.30.2
> 
