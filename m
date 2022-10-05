Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9F5F52A6
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Oct 2022 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJEKa5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Oct 2022 06:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJEKa4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Oct 2022 06:30:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C52D1F0;
        Wed,  5 Oct 2022 03:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965855; x=1696501855;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Wezh43SpRoN0/MWvN1oHmzbIRsNAJSzelgJtCEdWV6M=;
  b=WT2SiHk82pAPVIe/3nKMaBgxsrYgBG7f6ieP27sTDeqnp4ynrObCJokv
   sW8pjWOoMAyDyx2uMCeJfrdYUxI8fWqIHcgupEJ63NMH9+aTNBeLUaOjd
   teDde8y+v+/quJrAyX+aodgPe2dupAkQT6QuYKt/gwqhgPtw+BHJEgnOx
   Ekz7xvdplWrCnJRs2Sm6FHMWqw9c1Oi/YIQSgN3LHKCysOa3Tz2gHBov2
   Gs18rp7jqZlD1hrb3/i3p/bGwkfynuaLtkNOOzz8HcfSusz46ajwmblmM
   GiBD9SMkUUckUeupDKzq8gHs0JBLJwN/Z+Odr8zyMRw64kGgO7YtL7ltY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304696997"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304696997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:30:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="619426480"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="619426480"
Received: from refaase-mobl1.ger.corp.intel.com ([10.252.39.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:30:48 -0700
Date:   Wed, 5 Oct 2022 13:30:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <20221004143718.1076710-4-matthew.gerlach@linux.intel.com>
Message-ID: <2ee52b26-d34d-9599-a465-b3cce51f4b45@linux.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Please try to remember cc all people who have commented your patches when 
sending the next version.

On Tue, 4 Oct 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add generic support for MSIX interrupts for DFL devices.
> 
> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

> @@ -935,55 +948,74 @@ static u16 feature_id(u64 value)
>  }
>  
>  static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> -			      resource_size_t ofst, u16 fid,
> -			      unsigned int *irq_base, unsigned int *nr_irqs)
> +			      resource_size_t ofst, struct dfl_feature_info *finfo)
>  {
>  	void __iomem *base = binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr = 0;
>  	enum dfl_id_type type;
> -	int virq;
> -	u64 v;
> -
> -	type = feature_dev_id_type(binfo->feature_dev);
> +	u16 fid = finfo->fid;
> +	u64 v, dfh_ver;

Drop dfh_ver.

> +	int virq, off;
>  
>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
> -	 * current version DFL only provides mmio resources information for
> +	 * current version, DFHv0, only provides mmio resources information for
>  	 * each feature in DFL Header, no field for interrupt resources.
>  	 * Interrupt resource information is provided by specific mmio
>  	 * registers of each private feature which supports interrupt. So in
>  	 * order to parse and assign irq resources, DFL framework has to look
>  	 * into specific capability registers of these private features.
>  	 *
> -	 * Once future DFL version supports generic interrupt resource
> -	 * information in common DFL headers, the generic interrupt parsing
> -	 * code will be added. But in order to be compatible to old version
> +	 * DFHv1 supports generic interrupt resource information in DFHv1
> +	 * parameter blocks. But in order to be compatible to old version
>  	 * DFL, the driver may still fall back to these quirks.

I'm not convinced this comment is useful as is after the introduction of 
v1. It feels too focused on v0 limitations.

I suggest you move v0 limitations description to v0 block below and 
perhaps state in the end of it that comment that v1 is recommended for 
new things because it doesn't have those limitations. Or something along 
those lines.

>  	 */
> -	if (type == PORT_ID) {
> -		switch (fid) {
> -		case PORT_FEATURE_ID_UINT:
> -			v = readq(base + PORT_UINT_CAP);
> -			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +
> +	switch (finfo->dfh_version) {
> +	case 0:
> +		type = feature_dev_id_type(binfo->feature_dev);
> +		if (type == PORT_ID) {
> +			switch (fid) {
> +			case PORT_FEATURE_ID_UINT:
> +				v = readq(base + PORT_UINT_CAP);
> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +				break;
> +			case PORT_FEATURE_ID_ERROR:
> +				v = readq(base + PORT_ERROR_CAP);
> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +				break;
> +			}
> +		} else if (type == FME_ID) {
> +			if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> +				v = readq(base + FME_ERROR_CAP);
> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +			}
> +		}
> +		break;
> +
> +	case 1:
> +		if (!dfhv1_has_params(base))
>  			break;
> -		case PORT_FEATURE_ID_ERROR:
> -			v = readq(base + PORT_ERROR_CAP);
> -			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +
> +		off = dfhv1_find_param(base, ofst, DFHv1_PARAM_ID_MSIX);
> +		if (off < 0)
>  			break;
> -		}
> -	} else if (type == FME_ID) {
> -		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> -			v = readq(base + FME_ERROR_CAP);
> -			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		}
> +
> +		ibase = readl(base + off + DFHv1_PARAM_MSIX_STARTV);
> +		inr = readl(base + off + DFHv1_PARAM_MSIX_NUMV);
> +		break;
> +
> +	default:
> +		dev_warn(binfo->dev, "unexpected DFH version %lld\n", dfh_ver);

dfh_ver is uninitialized here. The compiler shouldn't have been happy with 
this.

> @@ -1041,21 +1073,33 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	if (binfo->len - ofst < size)
>  		return -EINVAL;
>  
> -	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> -	if (ret)
> -		return ret;
> -
>  	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
>  	if (!finfo)
>  		return -ENOMEM;
>  
>  	finfo->fid = fid;
>  	finfo->revision = revision;
> +	finfo->dfh_version = dfh_version;
>  	finfo->mmio_res.start = binfo->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> -	finfo->irq_base = irq_base;
> -	finfo->nr_irqs = nr_irqs;
> +
> +	ret = parse_feature_irqs(binfo, ofst, finfo);
> +	if (ret)
> +		return ret;

finfo has to be freed in case of an error.

Thanks for rearranging, it looks more logical now.

--
 i.
