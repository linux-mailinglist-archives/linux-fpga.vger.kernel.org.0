Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0201FFFD1
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Jun 2020 03:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgFSBkk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Jun 2020 21:40:40 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33537 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFSBkj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Jun 2020 21:40:39 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so7871271ilq.0;
        Thu, 18 Jun 2020 18:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJoP7oVOvzpVuZPM3osFjxe5D6t5ctLfG4HCj8088To=;
        b=QvepFfza0ezZ6GE9/Lk5XNGwVLRHCvoEV3lxSkvonpKyiO8IYyod7gBG2bLZbj7d25
         Ie0iMzKwdW8laLSjaWVQQPPoGF5IZoYOKAkmgxlnXuBoVqK60dzOe+tNZ8cUsk1jGBhL
         mVGl7+EtdTtt/HOc4hu5O208IcrsWSu4eehhQ6mdZiW4b80l0BBxBav6zZC6mh2L8YVl
         GVLBajyycq4RL4u3Fe4IKKrSU5L3NY3mND+Gj2hRs2RAHEINNaNi9KVCrpqYQSZqtp9O
         Mpc9eJJJteV923TlXA/jY2gsmeZqJJl+PTvrtzSvEpzIct9l3BHiQvBS5RTEAhSbetmm
         WrEw==
X-Gm-Message-State: AOAM53315IHhi6VSfe4xUHKfoFxRy0hRUBQomVfBAx6qOeo1CWdoOJiC
        h2ho+tCbIZXvrGhf2Ryb+Yo=
X-Google-Smtp-Source: ABdhPJyfe8V1yYPwY1ynMF8zhUqQIJoWWg7x/rgBPX8e9zy+pO7+hD6Bij8+mo58ek+D21nEI0JpmQ==
X-Received: by 2002:a92:dc47:: with SMTP id x7mr1487780ilq.130.1592530838660;
        Thu, 18 Jun 2020 18:40:38 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u2sm2346059ilg.29.2020.06.18.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:40:37 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:40:36 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] fpga: dfl: Use struct_size() in kzalloc()
Message-ID: <20200619014036.GF3685@epycbox.lan>
References: <20200617221039.GA21877@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617221039.GA21877@embeddedor>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 17, 2020 at 05:10:39PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> function dfl_feature_platform_data_size().
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/fpga/dfl.c | 3 +--
>  drivers/fpga/dfl.h | 6 ------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 990994874bf1..2dd13e036d45 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -487,8 +487,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	 * it will be automatically freed by device's release() callback,
>  	 * platform_device_release().
>  	 */
> -	pdata = kzalloc(dfl_feature_platform_data_size(binfo->feature_num),
> -			GFP_KERNEL);
> +	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2f5d3052e36e..044b0e88e5a8 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -299,12 +299,6 @@ struct dfl_feature_ops {
>  #define DFL_FPGA_FEATURE_DEV_FME		"dfl-fme"
>  #define DFL_FPGA_FEATURE_DEV_PORT		"dfl-port"
>  
> -static inline int dfl_feature_platform_data_size(const int num)
> -{
> -	return sizeof(struct dfl_feature_platform_data) +
> -		num * sizeof(struct dfl_feature);
> -}
> -
>  void dfl_fpga_dev_feature_uinit(struct platform_device *pdev);
>  int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>  			      struct dfl_feature_driver *feature_drvs);
> -- 
> 2.27.0
> 
Applied to for-next,

Thanks!
