Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD4640AF6
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Dec 2022 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiLBQiR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Dec 2022 11:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiLBQiF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Dec 2022 11:38:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48773F48;
        Fri,  2 Dec 2022 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669999081; x=1701535081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hGNc1g82zkLmEWQsUiwpumdAF8Ff8s0nd725mUW+1ko=;
  b=fwRtPbkF5g3cbjLofDjfaFjG2bUx7kSS3gVf37f/qWuBhtdWU2qQn1S/
   OZtONTKgdMMrSoaFJljooFHn4bgEc8Jkb9UmI7X36mqfkjRzfwJNyjnMz
   cQeoTC8rmtzIzlwnNAw0ZUu+zBff9YHPMZE4hZefjTNYciOVyY8FQU0mc
   mdXbn1EcwybNZoe4CiVveNkYuz+U0xgFinmsjKIwzNvfuuCEvIHK6h1Rs
   dsuz+2LtsTYn91d0PmjSJzyoKifZ9yFB1kep6tjzXlFYZmYOKHtO4y3qi
   JSRZ+JdJnrihx9LnWamioDl36hW4xyGjJH37ftl/dCuTBOhF2VAk+SzPR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="316015898"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="316015898"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 08:38:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="769653874"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="769653874"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 02 Dec 2022 08:37:52 -0800
Date:   Sat, 3 Dec 2022 00:28:11 +0800
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
Subject: Re: [PATCH v3 6/9] mfd: intel-m10-bmc: Downscope SPI defines &
 prefix with M10BMC_SPI
Message-ID: <Y4onmwWT8duVV0Sv@yilunxu-OptiPlex-7050>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202100841.4741-7-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-02 at 12:08:38 +0200, Ilpo Järvinen wrote:
> Move SPI based board definitions to per interface file from the global
> header. This makes it harder to use them accidently in the
> generic/interface agnostic code. Prefix the defines with M10BMC_SPI

I'm not sure if the register layout is actually bound to the bus
interface. My experience is the register layout is always decided by
board type. Is it possible there will be a new SPI based board but
has different register layout in future?

So is M10BMC_SPI_XXX a good name?

The same concern for PMCI in patch #7.

Thanks,
Yilun

> to make it more obvious these are related to SPI only.
> 
> Some bitfield defs are also moved to intel-m10-bmc-core which seems
> more appropriate for them.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c  | 11 ++++
>  drivers/mfd/intel-m10-bmc-spi.c   | 87 ++++++++++++++++++++++---------
>  include/linux/mfd/intel-m10-bmc.h | 46 ----------------
>  3 files changed, 73 insertions(+), 71 deletions(-)
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
> index 611a4ab42717..e99fe7c43314 100644
> --- a/drivers/mfd/intel-m10-bmc-spi.c
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -13,10 +13,47 @@
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> +#define M10BMC_SPI_LEGACY_BUILD_VER	0x300468
> +#define M10BMC_SPI_SYS_BASE		0x300800
> +#define M10BMC_SPI_SYS_END		0x300fff
> +#define M10BMC_SPI_FLASH_BASE		0x10000000
> +#define M10BMC_SPI_FLASH_END		0x1fffffff
> +#define M10BMC_SPI_MEM_END		M10BMC_SPI_FLASH_END
> +
> +/* Register offset of system registers */
> +#define NIOS2_FW_VERSION		0x0
> +#define M10BMC_SPI_MAC_LOW		0x10
> +#define M10BMC_SPI_MAC_HIGH		0x14
> +#define M10BMC_SPI_TEST_REG		0x3c
> +#define M10BMC_SPI_BUILD_VER		0x68
> +#define M10BMC_SPI_VER_LEGACY_INVALID	0xffffffff
> +
> +/* Secure update doorbell register, in system register region */
> +#define M10BMC_SPI_DOORBELL		0x400
> +
> +/* Authorization Result register, in system register region */
> +#define M10BMC_SPI_AUTH_RESULT		0x404
> +
> +/* Addresses for security related data in FLASH */
> +#define M10BMC_SPI_BMC_REH_ADDR		0x17ffc004
> +#define M10BMC_SPI_BMC_PROG_ADDR	0x17ffc000
> +#define M10BMC_SPI_BMC_PROG_MAGIC	0x5746
> +
> +#define M10BMC_SPI_SR_REH_ADDR		0x17ffd004
> +#define M10BMC_SPI_SR_PROG_ADDR		0x17ffd000
> +#define M10BMC_SPI_SR_PROG_MAGIC	0x5253
> +
> +#define M10BMC_SPI_PR_REH_ADDR		0x17ffe004
> +#define M10BMC_SPI_PR_PROG_ADDR		0x17ffe000
> +#define M10BMC_SPI_PR_PROG_MAGIC	0x5250
> +
> +/* Address of 4KB inverted bit vector containing staging area FLASH count */
> +#define M10BMC_SPI_STAGING_FLASH_COUNT	0x17ffb000
> +
>  static const struct regmap_range m10bmc_regmap_range[] = {
> -	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> -	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> -	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> +	regmap_reg_range(M10BMC_SPI_LEGACY_BUILD_VER, M10BMC_SPI_LEGACY_BUILD_VER),
> +	regmap_reg_range(M10BMC_SPI_SYS_BASE, M10BMC_SPI_SYS_END),
> +	regmap_reg_range(M10BMC_SPI_FLASH_BASE, M10BMC_SPI_FLASH_END),
>  };
>  
>  static const struct regmap_access_table m10bmc_access_table = {
> @@ -30,7 +67,7 @@ static struct regmap_config intel_m10bmc_regmap_config = {
>  	.reg_stride = 4,
>  	.wr_table = &m10bmc_access_table,
>  	.rd_table = &m10bmc_access_table,
> -	.max_register = M10BMC_MEM_END,
> +	.max_register = M10BMC_SPI_MEM_END,
>  };
>  
>  static int check_m10bmc_version(struct intel_m10bmc *ddata)
> @@ -41,16 +78,16 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>  	/*
>  	 * This check is to filter out the very old legacy BMC versions. In the
>  	 * old BMC chips, the BMC version info is stored in the old version
> -	 * register (M10BMC_LEGACY_BUILD_VER), so its read out value would have
> -	 * not been M10BMC_VER_LEGACY_INVALID (0xffffffff). But in new BMC
> +	 * register (M10BMC_SPI_LEGACY_BUILD_VER), so its read out value would have
> +	 * not been M10BMC_SPI_VER_LEGACY_INVALID (0xffffffff). But in new BMC
>  	 * chips that the driver supports, the value of this register should be
> -	 * M10BMC_VER_LEGACY_INVALID.
> +	 * M10BMC_SPI_VER_LEGACY_INVALID.
>  	 */
> -	ret = m10bmc_raw_read(ddata, M10BMC_LEGACY_BUILD_VER, &v);
> +	ret = m10bmc_raw_read(ddata, M10BMC_SPI_LEGACY_BUILD_VER, &v);
>  	if (ret)
>  		return -ENODEV;
>  
> -	if (v != M10BMC_VER_LEGACY_INVALID) {
> +	if (v != M10BMC_SPI_VER_LEGACY_INVALID) {
>  		dev_err(ddata->dev, "bad version M10BMC detected\n");
>  		return -ENODEV;
>  	}
> @@ -92,23 +129,23 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  }
>  
>  static const struct m10bmc_csr_map m10bmc_spi_csr_map = {
> -	.base = M10BMC_SYS_BASE,
> -	.build_version = M10BMC_BUILD_VER,
> +	.base = M10BMC_SPI_SYS_BASE,
> +	.build_version = M10BMC_SPI_BUILD_VER,
>  	.fw_version = NIOS2_FW_VERSION,
> -	.mac_low = M10BMC_MAC_LOW,
> -	.mac_high = M10BMC_MAC_HIGH,
> -	.doorbell = M10BMC_DOORBELL,
> -	.auth_result = M10BMC_AUTH_RESULT,
> -	.bmc_prog_addr = BMC_PROG_ADDR,
> -	.bmc_reh_addr = BMC_REH_ADDR,
> -	.bmc_magic = BMC_PROG_MAGIC,
> -	.sr_prog_addr = SR_PROG_ADDR,
> -	.sr_reh_addr = SR_REH_ADDR,
> -	.sr_magic = SR_PROG_MAGIC,
> -	.pr_prog_addr = PR_PROG_ADDR,
> -	.pr_reh_addr = PR_REH_ADDR,
> -	.pr_magic = PR_PROG_MAGIC,
> -	.rsu_update_counter = STAGING_FLASH_COUNT,
> +	.mac_low = M10BMC_SPI_MAC_LOW,
> +	.mac_high = M10BMC_SPI_MAC_HIGH,
> +	.doorbell = M10BMC_SPI_DOORBELL,
> +	.auth_result = M10BMC_SPI_AUTH_RESULT,
> +	.bmc_prog_addr = M10BMC_SPI_BMC_PROG_ADDR,
> +	.bmc_reh_addr = M10BMC_SPI_BMC_REH_ADDR,
> +	.bmc_magic = M10BMC_SPI_BMC_PROG_MAGIC,
> +	.sr_prog_addr = M10BMC_SPI_SR_PROG_ADDR,
> +	.sr_reh_addr = M10BMC_SPI_SR_REH_ADDR,
> +	.sr_magic = M10BMC_SPI_SR_PROG_MAGIC,
> +	.pr_prog_addr = M10BMC_SPI_PR_PROG_ADDR,
> +	.pr_reh_addr = M10BMC_SPI_PR_REH_ADDR,
> +	.pr_magic = M10BMC_SPI_PR_PROG_MAGIC,
> +	.rsu_update_counter = M10BMC_SPI_STAGING_FLASH_COUNT,
>  };
>  
>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 91567375f1bf..71ace732bb48 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -9,39 +9,9 @@
>  
>  #include <linux/regmap.h>
>  
> -#define M10BMC_LEGACY_BUILD_VER		0x300468
> -#define M10BMC_SYS_BASE			0x300800
> -#define M10BMC_SYS_END			0x300fff
> -#define M10BMC_FLASH_BASE		0x10000000
> -#define M10BMC_FLASH_END		0x1fffffff
> -#define M10BMC_MEM_END			M10BMC_FLASH_END
> -
>  #define M10BMC_STAGING_BASE		0x18000000
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
> @@ -102,22 +72,6 @@
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
