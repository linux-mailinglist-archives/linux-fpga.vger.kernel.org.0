Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919050A32B
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389604AbiDUOtR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389341AbiDUOtN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 10:49:13 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8A275C0;
        Thu, 21 Apr 2022 07:46:23 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id j17so5202382pfi.9;
        Thu, 21 Apr 2022 07:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68aQiXtJdbSqo/3JtN5CLu/jqQDwbP40/JDr4/iZoI8=;
        b=AOb8YbpqI+D2yBpyli2Ne6uoCnm0Ew+iIur468RY9YJ4iZPnQfyakYdHC5ivDi3jyw
         RS7FH82LKl+j/3DNTVCt1gLJmU963GYDOEtIbvD+DkPzhPnPSKf1f5ieWmSNu1i0giGb
         15MfYJrQI7xoKcWMyyEB4aat09CFF+661yPturtmLrk32vYnKP92ipuvGQXgYQT1a8Mc
         ytsz2cdMVCsv5gQlsog2sCr5qn7mQfEg8VShhesPj0B4DKGkbuonnaniwaZPa7Cg44M6
         QgWMI1v+1r/IVfVyNhB4EGr6BgY7kFJgcSas84/3F3+jDgoZlvuEE4/8VsSJGggX2DP3
         L8Fg==
X-Gm-Message-State: AOAM533H7xJUuau9B2N1DEzhexueARJnJOA7qPKkYBfmZ+FPKpSNePlZ
        R/+hq2dm2mHEylugxBPh++c=
X-Google-Smtp-Source: ABdhPJw+lELoD2P97sAlP0tY8bc4cqSyEaNhgwVyzU5Hi9CD89FiMOgc+2SwbCzF3OA5TNVU5asFOA==
X-Received: by 2002:aa7:8241:0:b0:509:979d:c760 with SMTP id e1-20020aa78241000000b00509979dc760mr29335995pfn.84.1650552383104;
        Thu, 21 Apr 2022 07:46:23 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm26260875pfl.148.2022.04.21.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:46:22 -0700 (PDT)
Date:   Thu, 21 Apr 2022 07:46:21 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v7 1/2] fpga: dfl: check feature type before parse irq
 info
Message-ID: <YmFuPdzQCL5LwH2F@archbook>
References: <20220419032942.427429-1-tianfei.zhang@intel.com>
 <20220419032942.427429-2-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419032942.427429-2-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 18, 2022 at 11:29:41PM -0400, Tianfei Zhang wrote:
> From: Tianfei zhang <tianfei.zhang@intel.com>
> 
> Previously the feature IDs defined are unique, no matter
> which feature type. But currently we want to extend its
> usage to have a per-type feature ID space, so this patch
> adds feature type checking as well just before look into
> feature ID for different features which have irq info.
> 
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
> v7:
>   - Add Reviewed-by and Acked-by tag.
> v4:
>   - Fix the git commit from Hao's comments.
>   - Split documentation into another patch.
> v3:
>   - Remove "Fixes" in commit log with Hao's comment, this is a
>     extension not a bug fix.
> v2:
>   - add DFL Feature ID Registry in documentation.
> ---
>  drivers/fpga/dfl.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..6bff39ff21a0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  {
>  	void __iomem *base = binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr = 0;
> +	enum dfl_id_type type;
>  	int virq;
>  	u64 v;
>  
> +	type = feature_dev_id_type(binfo->feature_dev);
> +
>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
>  	 * current version DFL only provides mmio resources information for
> @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  	 * code will be added. But in order to be compatible to old version
>  	 * DFL, the driver may still fall back to these quirks.
>  	 */
> -	switch (fid) {
> -	case PORT_FEATURE_ID_UINT:
> -		v = readq(base + PORT_UINT_CAP);
> -		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> -		break;
> -	case PORT_FEATURE_ID_ERROR:
> -		v = readq(base + PORT_ERROR_CAP);
> -		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> -		break;
> -	case FME_FEATURE_ID_GLOBAL_ERR:
> -		v = readq(base + FME_ERROR_CAP);
> -		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		break;
> +	if (type == PORT_ID) {
> +		switch (fid) {
> +		case PORT_FEATURE_ID_UINT:
> +			v = readq(base + PORT_UINT_CAP);
> +			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +			break;
> +		case PORT_FEATURE_ID_ERROR:
> +			v = readq(base + PORT_ERROR_CAP);
> +			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +			break;
> +		}
> +	} else if (type == FME_ID) {
> +		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> +			v = readq(base + FME_ERROR_CAP);
> +			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		}
>  	}
>  
>  	if (!inr) {
> -- 
> 2.26.2
> 
