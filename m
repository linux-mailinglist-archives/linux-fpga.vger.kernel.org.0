Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA43507FFC
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Apr 2022 06:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354173AbiDTE1D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Apr 2022 00:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTE1C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 20 Apr 2022 00:27:02 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E212AD1;
        Tue, 19 Apr 2022 21:24:17 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id e62-20020a17090a6fc400b001d2cd8e9b0aso823982pjk.5;
        Tue, 19 Apr 2022 21:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3G/zycN/gWAd7Y5wcbb/visDS0CApx2O53NC+SKxow=;
        b=WBIlZfN1BjXkBtEhIlGns1kXe23njaMQ6MM9dpHOf9kxcoeblNl8ucAXV84odagNQ5
         MZkYNxvtHPe4e7HxEdJ/jMAbm+g8z2q4XDTairu42M6gRRXmRdk7g1H468oU7UdK1IeZ
         cgYxZZGvJMzh5Rx4Hcw6KgY/P+yxdObZnwPJTST15RAWBrm3zFfZzxxlUDqFiWwRwQMF
         jaqsfBddZBPqF49AZH0l5EFW1pinTvlNEMfqyDSKoLQGBM0XosKiPomLUzS8YUHTdj9f
         JuMQpW+9ScCCp0XFX/PVSk4tDEEGevW2OEW5y8un7FXxoVWfi29BTSrCvN3wXEhd79WK
         Gh/Q==
X-Gm-Message-State: AOAM530VWTWBQpjH+pK7f5UrZKEzSnnczNeRI5UrUDFn6yM+ZuxzUL3/
        OzoonA0x6jhHzc9SpG6SftY=
X-Google-Smtp-Source: ABdhPJwR2+M3apg3q4iRN5ROp+CeVXqPxI1Vk/Z71Y0mjiIsmPluV9gkFIqciPE6WGVIfZRDdCuNLw==
X-Received: by 2002:a17:90b:2691:b0:1d2:72b9:b9b with SMTP id pl17-20020a17090b269100b001d272b90b9bmr2261004pjb.80.1650428657128;
        Tue, 19 Apr 2022 21:24:17 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id d18-20020a056a0010d200b004fa2e13ce80sm19353650pfu.76.2022.04.19.21.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:24:16 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:24:15 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-pr-ip: fix unsigned comparison with less
 than zero
Message-ID: <Yl+K789ZUWd5Si0B@archbook>
References: <20220405185349.220607-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405185349.220607-1-marpagan@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Marco,

On Tue, Apr 05, 2022 at 08:53:49PM +0200, Marco Pagani wrote:
> Fix the "comparison with less than zero" warning reported by
> cppcheck for the unsigned (size_t) parameter "count" of the
> "alt_pr_fpga_write()" function.
> 
Should this have a Reported-by: tag?
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/altera-pr-ip-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index be0667968d33..2ff3d8e46a0c 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
>  	u32 *buffer_32 = (u32 *)buf;
>  	size_t i = 0;
>  
> -	if (count <= 0)
> +	if (count == 0)
>  		return -EINVAL;

if (!count)
	return -EINVAL?
>  
>  	/* Write out the complete 32-bit chunks */
> -- 
> 2.35.1

Cheers,
Moritz
> 
