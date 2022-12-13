Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939E764B7F4
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiLMO6k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 09:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMO6i (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 09:58:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B020982;
        Tue, 13 Dec 2022 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670943517; x=1702479517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n1Iz0xuquQcsewEe9eCEHtwu2R9ypF9zn7yduOFE3ys=;
  b=k6Qye6OdTxWgjD5MMLVKBylmv0MB4UeKoLNOilFrCNJKWqcWV74WJZeP
   xgadC4g8vIblj5vCQfMQ6QiRRYACTMPgce7knlgfyRv4P2ywOSSxZzV9D
   9wK7OxC2EY0/6tnHFdmKRYjyhA+ixBgaO7SwvA8y7uaLN4j0P/+r63v98
   DDS6PlchFHKGf4+jZOw0O2D0/CkYHIf9scNnTXWrb0P+z4eY2H3A5oDpx
   Ty0b6wS1jVNWGjx3g0pnQsHAoOXiW+zbNcIc07hSUUmVZEgPrvfSIZg8L
   ohVsulF7UNaYY5qied8MI+jtOEB98+ylAuGveTG7Ncwec5sDL6kdKuHIi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319289577"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="319289577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 06:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="598822748"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="598822748"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2022 06:58:33 -0800
Date:   Tue, 13 Dec 2022 22:48:41 +0800
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
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 8/8] fpga: m10bmc-sec: Add support for N6000
Message-ID: <Y5iQyefMnpxJsBFw@yilunxu-OptiPlex-7050>
References: <20221211103913.5287-1-ilpo.jarvinen@linux.intel.com>
 <20221211103913.5287-9-ilpo.jarvinen@linux.intel.com>
 <Y5gXUMAvN5xBOGpF@yilunxu-OptiPlex-7050>
 <225b7feb-fa23-fdc-42af-b0a0f4737fca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <225b7feb-fa23-fdc-42af-b0a0f4737fca@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-13 at 12:18:50 +0200, Ilpo Järvinen wrote:
> On Tue, 13 Dec 2022, Xu Yilun wrote:
> 
> > On 2022-12-11 at 12:39:13 +0200, Ilpo Järvinen wrote:
> > > Add support for PMCI-based flash access path and N6000 sec update
> > > support. Access to flash staging area is different for N6000 from that
> > > of the SPI interfaced counterparts.
> > > 
> > > Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
> > > differentiations for the flash access path for sec update and make
> > > m10bmc_sec_read/write() in sec update driver to use the new operations.
> > > 
> > > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/fpga/intel-m10-bmc-sec-update.c |  65 ++++++++++-
> > >  drivers/mfd/intel-m10-bmc-pmci.c        | 145 ++++++++++++++++++++++++
> > >  include/linux/mfd/intel-m10-bmc.h       |  14 +++
> > >  3 files changed, 223 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > index 9922027856a4..885e38f13897 100644
> > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > @@ -14,6 +14,20 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > >  
> > > +#define M10BMC_PMCI_FLASH_MUX_CTRL	0x1d0
> > > +#define FLASH_MUX_SELECTION		GENMASK(2, 0)
> > > +#define FLASH_MUX_IDLE			0
> > > +#define FLASH_MUX_NIOS			1
> > > +#define FLASH_MUX_HOST			2
> > > +#define FLASH_MUX_PFL			4
> > > +#define get_flash_mux(mux)		FIELD_GET(FLASH_MUX_SELECTION, mux)
> > > +
> > > +#define FLASH_NIOS_REQUEST		BIT(4)
> > > +#define FLASH_HOST_REQUEST		BIT(5)
> > > +
> > > +#define M10_FLASH_INT_US		1
> > > +#define M10_FLASH_TIMEOUT_US		10000
> > > +
> > >  struct m10bmc_sec {
> > >  	struct device *dev;
> > >  	struct intel_m10bmc *m10bmc;
> > > @@ -21,6 +35,7 @@ struct m10bmc_sec {
> > >  	char *fw_name;
> > >  	u32 fw_name_id;
> > >  	bool cancel_request;
> > > +	struct mutex flash_mutex;
> > >  };
> > >  
> > >  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> > > @@ -31,6 +46,24 @@ static DEFINE_XARRAY_ALLOC(fw_upload_xa);
> > >  #define REH_MAGIC		GENMASK(15, 0)
> > >  #define REH_SHA_NUM_BYTES	GENMASK(31, 16)
> > >  
> > > +static int m10bmc_sec_set_flash_host_mux(struct intel_m10bmc *m10bmc, bool request)
> > > +{
> > > +	u32 ctrl;
> > > +	int ret;
> > > +
> > > +	ret = regmap_update_bits(m10bmc->regmap, M10BMC_PMCI_FLASH_MUX_CTRL,
> > > +				 FLASH_HOST_REQUEST,
> > > +				 FIELD_PREP(FLASH_HOST_REQUEST, request));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_read_poll_timeout(m10bmc->regmap,
> > > +					M10BMC_PMCI_FLASH_MUX_CTRL, ctrl,
> > > +					request ? (get_flash_mux(ctrl) == FLASH_MUX_HOST) :
> > > +						  (get_flash_mux(ctrl) != FLASH_MUX_HOST),
> > > +					M10_FLASH_INT_US, M10_FLASH_TIMEOUT_US);
> > > +}
> > > +
> > >  static int m10bmc_sec_write(struct m10bmc_sec *sec, const u8 *buf, u32 offset, u32 size)
> > >  {
> > >  	struct intel_m10bmc *m10bmc = sec->m10bmc;
> > > @@ -41,6 +74,15 @@ static int m10bmc_sec_write(struct m10bmc_sec *sec, const u8 *buf, u32 offset, u
> > >  	u32 leftover_tmp = 0;
> > >  	int ret;
> > >  
> > > +	if (sec->m10bmc->flash_bulk_ops) {
> > > +		mutex_lock(&sec->flash_mutex);
> > > +		/* On write, firmware manages flash MUX */
> > > +		ret = sec->m10bmc->flash_bulk_ops->write(m10bmc, buf, offset, size);
> > > +		mutex_unlock(&sec->flash_mutex);
> > > +
> > > +		return ret;
> > > +	}
> > > +
> > >  	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
> > >  		return -EINVAL;
> > >  
> > > @@ -69,7 +111,21 @@ static int m10bmc_sec_read(struct m10bmc_sec *sec, u8 *buf, u32 addr, u32 size)
> > >  	u32 leftover_offset = read_count * stride;
> > >  	u32 leftover_size = size - leftover_offset;
> > >  	u32 leftover_tmp;
> > > -	int ret;
> > > +	int ret, ret2;
> > > +
> > > +	if (sec->m10bmc->flash_bulk_ops) {
> > > +		mutex_lock(&sec->flash_mutex);
> > > +		ret = m10bmc_sec_set_flash_host_mux(m10bmc, true);
> > > +		if (ret)
> > > +			goto mux_fail;
> > 
> > If the flash host mux fail, we still need to un-mux it?
> 
> It seemed safer to attempt to set it back after the code tried to alter 
> the MUX setting. I don't see how it could be harmful. Likely we're in the 
> deep end in that case anyway so setting it back might just fails too 
> (which is harmless sans the small extra delay) or just confirms that the 
> value wasn't changed.

Fine. It's good to me.

> 
> -- 
>  i.
> 
> > > +		ret = sec->m10bmc->flash_bulk_ops->read(m10bmc, buf, addr, size);
> > > +mux_fail:
> > > +		ret2 = m10bmc_sec_set_flash_host_mux(m10bmc, false);
> > > +		mutex_unlock(&sec->flash_mutex);
> > > +		if (ret)
> > > +			return ret;
> > > +		return ret2;
> > > +	}
> > >  
> > >  	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
> > >  		return -EINVAL;
> > > @@ -611,6 +667,8 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	mutex_init(&sec->flash_mutex);
> > > +
> > >  	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
> > >  			sec->fw_name_id);
> > >  	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> > > @@ -633,6 +691,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
> > >  fw_uploader_fail:
> > >  	kfree(sec->fw_name);
> > >  fw_name_fail:
> > > +	mutex_destroy(&sec->flash_mutex);
> > >  	xa_erase(&fw_upload_xa, sec->fw_name_id);
> > >  	return ret;
> > >  }
> > 

