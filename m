Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614D064AF5E
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 06:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiLMFgT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 00:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLMFgR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 00:36:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9713E16;
        Mon, 12 Dec 2022 21:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670909777; x=1702445777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liEEZEKTglWJ0qgi+YWfT/4zgdb8ql5I6ijkBiYHO9c=;
  b=PfleHhoHKodcotL3Mo47NYJXozQDkhMTevk4NehTWe0+6rmIaHOajotL
   uRz9fbL8dhvV7pCjBICY4Fkh0/WVhSSumf7sTl7aXYiFyOCgihxfKQ6VK
   u9CbYpwqFG0lm7tt7NI991nfBBTjmiAc4ifPdniH4IrmShrJ9UbN+2BJ1
   5Qkv1q6D9Cdih2jCMgNOYrkMrNU79UsomXgAvF2jiPnmfEpSVtHmQLYwh
   tzOcwNgn2UHvBZW+uPemWwDghF/WFHHxPBEoCVW/XEZMjjRUIW5cDehPi
   D6DNgv1dPOX7eXaaWZmVkhxi6qyTMINEgPzsVzIPP/t4Asttl6LUy7d+/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="301461473"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="301461473"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 21:36:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="755248060"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="755248060"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2022 21:36:11 -0800
Date:   Tue, 13 Dec 2022 13:26:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v6 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y5gM/L3wufo0/m0y@yilunxu-OptiPlex-7050>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
 <20221209214523.3484193-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209214523.3484193-4-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-09 at 13:45:22 -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

[...]
 
>  /*
>   * when create sub feature instances, for private features, it doesn't need
>   * to provide resource size and feature id as they could be read from DFH
> @@ -1023,39 +1125,69 @@ static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
>  			resource_size_t ofst, resource_size_t size, u16 fid)
>  {
> -	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> +	resource_size_t start, end;
> +	int dfh_psize = 0;
>  	u8 revision = 0;
> +	u64 v, addr_off;
> +	u8 dfh_ver = 0;
>  	int ret;
> -	u64 v;
>  
>  	if (fid != FEATURE_ID_AFU) {
>  		v = readq(binfo->ioaddr + ofst);
>  		revision = FIELD_GET(DFH_REVISION, v);
> -
> +		dfh_ver = FIELD_GET(DFH_VERSION, v);
>  		/* read feature size and id if inputs are invalid */
>  		size = size ? size : feature_size(v);
>  		fid = fid ? fid : feature_id(v);
> +		if (dfh_ver == 1) {
> +			dfh_psize = dfh_get_psize(binfo->ioaddr + ofst, size);
> +			if (dfh_psize < 0) {
> +				dev_err(binfo->dev,
> +					"failed to read size of DFHv1 parameters %d\n",
> +					dfh_psize);
> +				return dfh_psize;
> +			}
> +			dev_dbg(binfo->dev, "dfhv1_psize %d\n", dfh_psize);
> +		}
>  	}
>  
>  	if (binfo->len - ofst < size)
>  		return -EINVAL;
>  
> -	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> -	if (ret)
> -		return ret;
> -
> -	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
> +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);

Please use size_add(). See Documentation/process/deprecated.rst for
details.

Others look good to me.

Yilun
