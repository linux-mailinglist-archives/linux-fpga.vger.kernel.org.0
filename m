Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9B6EA150
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Apr 2023 03:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjDUBw6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 21:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDUBwz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 21:52:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA9C6E92;
        Thu, 20 Apr 2023 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682041972; x=1713577972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wf2qRT499V++XGkaDgCOEie+m/8H5p5OlkdjwovLSvg=;
  b=AdWJmUnA02Jv4dxiKHgqnU11+QJg3B8yB+C2fwEO4ttNfstB/hNDyTwI
   9i8oSCjkn65U5KK7c/EK3UruWFF6o4z8dVMNZpFb/rdpUuRUVQEsB0kuP
   WHRq/lISYcW66oWRXJdyZOvkRP+UuRW1ETrByGIhohFSsOWh/QNfckDAY
   LuR4IbOVejckAJ+ZXiW87h1f1LBT8ygFEBn3lfbhOLmkQRkolo7uxpj5O
   Gqxt4Oq3wFcnsaBGmnAFVEcLE6qbUKYliZGXNvIrbyR4tif6TS7SKYOcS
   oHJKyJ39DMMr8yUJvVfCLTixyRkqTHcwoMaqc+NgYQ/D3gTGaBRmiv5Cs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348684361"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="348684361"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 18:52:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724637676"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="724637676"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2023 18:52:24 -0700
Date:   Fri, 21 Apr 2023 17:52:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mfd: intel-m10-bmc: Create
 m10bmc_sys_update_bits()
Message-ID: <ZEJc9n5p38eYziDX@yilunxu-OptiPlex-7050>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-17 at 12:26:51 +0300, Ilpo Järvinen wrote:
> Wrap regmap_update_bits() with m10bmc_sys_update_bits() in order to be
> able to add additional checks into it.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 30 ++++++++++++-------------
>  drivers/mfd/intel-m10-bmc-core.c        |  9 ++++++++
>  include/linux/mfd/intel-m10-bmc.h       |  4 ++++
>  3 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index d7e2f9f461bc..fe0127a58eff 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -376,12 +376,11 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>  	u32 doorbell_reg, progress, status;
>  	int ret, err;
>  
> -	ret = regmap_update_bits(sec->m10bmc->regmap,
> -				 csr_map->base + csr_map->doorbell,
> -				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
> -				 DRBL_RSU_REQUEST |
> -				 FIELD_PREP(DRBL_HOST_STATUS,
> -					    HOST_STATUS_IDLE));
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
> +				     DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
> +				     DRBL_RSU_REQUEST |
> +				     FIELD_PREP(DRBL_HOST_STATUS,
> +						HOST_STATUS_IDLE));
>  	if (ret)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  
> @@ -450,11 +449,10 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>  	u32 doorbell_reg, status;
>  	int ret;
>  
> -	ret = regmap_update_bits(sec->m10bmc->regmap,
> -				 csr_map->base + csr_map->doorbell,
> -				 DRBL_HOST_STATUS,
> -				 FIELD_PREP(DRBL_HOST_STATUS,
> -					    HOST_STATUS_WRITE_DONE));
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
> +				     DRBL_HOST_STATUS,
> +				     FIELD_PREP(DRBL_HOST_STATUS,
> +						HOST_STATUS_WRITE_DONE));
>  	if (ret)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  
> @@ -517,11 +515,10 @@ static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
>  	if (rsu_prog(doorbell) != RSU_PROG_READY)
>  		return FW_UPLOAD_ERR_BUSY;
>  
> -	ret = regmap_update_bits(sec->m10bmc->regmap,
> -				 csr_map->base + csr_map->doorbell,
> -				 DRBL_HOST_STATUS,
> -				 FIELD_PREP(DRBL_HOST_STATUS,
> -					    HOST_STATUS_ABORT_RSU));
> +	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
> +				     DRBL_HOST_STATUS,
> +				     FIELD_PREP(DRBL_HOST_STATUS,
> +						HOST_STATUS_ABORT_RSU));
>  	if (ret)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  
> @@ -764,3 +761,4 @@ module_platform_driver(intel_m10bmc_sec_driver);
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index c0b8209fd842..dab1bb152fd6 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -12,6 +12,15 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  
> +int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
> +			   unsigned int msk, unsigned int val)
> +{
> +	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
> +
> +	return regmap_update_bits(m10bmc->regmap, csr_map->base + offset, msk, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(m10bmc_sys_update_bits, INTEL_M10_BMC_CORE);
> +
>  static ssize_t bmc_version_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 1812ebfa11a8..5418f7279ed0 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -251,6 +251,7 @@ struct intel_m10bmc {
>   *
>   * m10bmc_raw_read - read m10bmc register per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
> + * m10bmc_sys_update_bits - update m10bmc system register per offset
>   */
>  static inline int
>  m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> @@ -282,6 +283,9 @@ static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offs
>  	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
>  }
>  
> +int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
> +			   unsigned int msk, unsigned int val);
> +
>  /*
>   * MAX10 BMC Core support
>   */
> -- 
> 2.30.2
> 
