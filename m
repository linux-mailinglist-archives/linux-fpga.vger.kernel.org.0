Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAB551FA2
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbiFTPBo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbiFTPB1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 11:01:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51A33E82;
        Mon, 20 Jun 2022 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655735252; x=1687271252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WsS4aKTNsBEfsxzyCelSOGWceTw88jDLbhP2Gba4nWQ=;
  b=iqG69QHZ2uVM+QEuQPaizoPWUNIGADlwPmOLy6rVZ2rxPMdAsR47dmOD
   WVG/67BFwkyB3x/PdsSIo56GI6Rcvvb52IBmfXvRUGkh/j+WioAtYK2H/
   jhVdIFx/HALAdH7vpSozrJt7fUD9qoiXTOZLLpaL/8UBMVIP4pOHhWW+v
   cRQAIz3TnIS3cF4X1nxa8nvLFfkMCkndolHsS+qyVJFPsogCjesmN+3vj
   kkfoRXNnTXQv+rT3RaghvJ6BlcCUxXry36AYtMhYLFVpTFwE+d5KLzzRX
   gepUaGrYXkB+c2SE2aQukDUBQl8JBPUOdHusfIQ0qpV/grWNMycrxyNmZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260341636"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260341636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 07:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="689487163"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2022 07:27:26 -0700
Date:   Mon, 20 Jun 2022 22:19:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     lee.jones@linaro.org, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v2 4/4] mfd: intel-m10-bmc: support multiple register
 layouts
Message-ID: <20220620141919.GA1417169@yilunxu-OptiPlex-7050>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-5-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617020405.128352-5-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 16, 2022 at 10:04:05PM -0400, Tianfei Zhang wrote:
> There are different base addresses for the MAX10 CSR register.

Actually I see differences for each register, not only the register
base...

> Introducing a new data structure m10bmc_csr for the register
> definition of MAX10 CSR. Embedded m10bmc_csr into struct
> intel_m10bmc to support multiple register layouts.

Since the new BMC has different connections to host, different register
layouts, different sub devices. Actually I can hardly find anything to
share between them, so how about we just create a new driver for your
new BMC?

Thanks,
Yilun

> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc-core.c  | 30 +++++++++++++++++++++++++-----
>  include/linux/mfd/intel-m10-bmc.h | 20 +++++++++++++++++++-
>  2 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index c6a1a4c28357..f85f8e2aa9a1 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -10,6 +10,22 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  
> +static const struct m10bmc_csr m10bmc_pmci_csr = {
> +	.base = M10BMC_PMCI_SYS_BASE,
> +	.build_version = M10BMC_PMCI_BUILD_VER,
> +	.fw_version = NIOS2_PMCI_FW_VERSION,
> +	.mac_low = M10BMC_PMCI_MAC_LOW,
> +	.mac_high = M10BMC_PMCI_MAC_HIGH,
> +};
> +
> +static const struct m10bmc_csr m10bmc_spi_csr = {
> +	.base = M10BMC_SYS_BASE,
> +	.build_version = M10BMC_BUILD_VER,
> +	.fw_version = NIOS2_FW_VERSION,
> +	.mac_low = M10BMC_MAC_LOW,
> +	.mac_high = M10BMC_MAC_HIGH,
> +};
> +
>  static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
>  	{ .name = "n6000bmc-hwmon" },
>  	{ .name = "n6000bmc-sec-update" }
> @@ -36,7 +52,7 @@ static ssize_t bmc_version_show(struct device *dev,
>  	unsigned int val;
>  	int ret;
>  
> -	ret = m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
> +	ret = m10bmc_sys_read(ddata, ddata->csr->build_version, &val);
>  	if (ret)
>  		return ret;
>  
> @@ -51,7 +67,7 @@ static ssize_t bmcfw_version_show(struct device *dev,
>  	unsigned int val;
>  	int ret;
>  
> -	ret = m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
> +	ret = m10bmc_sys_read(ddata, ddata->csr->fw_version, &val);
>  	if (ret)
>  		return ret;
>  
> @@ -66,11 +82,11 @@ static ssize_t mac_address_show(struct device *dev,
>  	unsigned int macaddr_low, macaddr_high;
>  	int ret;
>  
> -	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
> +	ret = m10bmc_sys_read(ddata, ddata->csr->mac_low, &macaddr_low);
>  	if (ret)
>  		return ret;
>  
> -	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
> +	ret = m10bmc_sys_read(ddata, ddata->csr->mac_high, &macaddr_high);
>  	if (ret)
>  		return ret;
>  
> @@ -91,7 +107,7 @@ static ssize_t mac_count_show(struct device *dev,
>  	unsigned int macaddr_high;
>  	int ret;
>  
> -	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
> +	ret = m10bmc_sys_read(ddata, ddata->csr->mac_high, &macaddr_high);
>  	if (ret)
>  		return ret;
>  
> @@ -163,18 +179,22 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
>  	case M10_N3000:
>  		cells = m10bmc_pacn3000_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> +		m10bmc->csr = &m10bmc_spi_csr;
>  		break;
>  	case M10_D5005:
>  		cells = m10bmc_d5005_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> +		m10bmc->csr = &m10bmc_spi_csr;
>  		break;
>  	case M10_N5010:
>  		cells = m10bmc_n5010_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> +		m10bmc->csr = &m10bmc_spi_csr;
>  		break;
>  	case M10_N6000:
>  		cells = m10bmc_n6000_bmc_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
> +		m10bmc->csr = &m10bmc_pmci_csr;
>  		break;
>  	default:
>  		return -ENODEV;
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 83c4d3993dcb..3a4fdab2acbd 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -125,6 +125,11 @@
>  #define M10BMC_PMCI_TELEM_START		0x400
>  #define M10BMC_PMCI_TELEM_END		0x78c
>  
> +#define M10BMC_PMCI_BUILD_VER   0x0
> +#define NIOS2_PMCI_FW_VERSION   0x4
> +#define M10BMC_PMCI_MAC_LOW    0x20
> +#define M10BMC_PMCI_MAC_HIGH    0x24
> +
>  /* Supported MAX10 BMC types */
>  enum m10bmc_type {
>  	M10_N3000,
> @@ -133,16 +138,29 @@ enum m10bmc_type {
>  	M10_N6000
>  };
>  
> +/**
> + * struct m10bmc_csr - Intel MAX 10 BMC CSR register
> + */
> +struct m10bmc_csr {
> +	unsigned int base;
> +	unsigned int build_version;
> +	unsigned int fw_version;
> +	unsigned int mac_low;
> +	unsigned int mac_high;
> +};
> +
>  /**
>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>   * @dev: this device
>   * @regmap: the regmap used to access registers by m10bmc itself
>   * @type: the type of MAX10 BMC
> + * @csr: the register definition of MAX10 BMC
>   */
>  struct intel_m10bmc {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	enum m10bmc_type type;
> +	const struct m10bmc_csr *csr;
>  };
>  
>  /*
> @@ -174,7 +192,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>   * M10BMC_SYS_BASE accordingly.
>   */
>  #define m10bmc_sys_read(m10bmc, offset, val) \
> -	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> +	m10bmc_raw_read(m10bmc, m10bmc->csr->base + (offset), val)
>  
>  /*
>   * MAX10 BMC Core support
> -- 
> 2.26.2
