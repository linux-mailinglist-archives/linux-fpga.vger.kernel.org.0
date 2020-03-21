Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B291718E427
	for <lists+linux-fpga@lfdr.de>; Sat, 21 Mar 2020 21:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCUUKl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Mar 2020 16:10:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41886 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCUUKl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Mar 2020 16:10:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so5228377pfz.8;
        Sat, 21 Mar 2020 13:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Jh1bnx0UpgYqbuOdXhZ1LNPb9nZTunrQ7Ptqpk4UuQ=;
        b=QuUhz+R9BgkWnWHsjj3/KJP3CuGrfLalpxr3Cv+76lQZGVXhQxrBx4tExuFf4lwQld
         IozwyyENF9kXn0mnQdI/cGfQ5+Hj+beV5Mc2IEd7eWIkuZ3Gcatv7YjT6swOZ233efSB
         6rk9lcqjFjSliEWGrV/+rUv4rh7Y811zaLj49Dmxi65Q6hYb84N+lxKSlK4YkKVRthOY
         wcTq8KM5/U2JwR665sQS3HMBC4D6UbhZJ2fHx6a3J12t14ilc8L+bI2XeU7wRBq258Xl
         flleJzx3imJuKcFVJR/Bb88mAUwDZoC7JYwFoK+7JVxO/NJHQHRM4yNZc6m4UiLBPBmR
         R2dw==
X-Gm-Message-State: ANhLgQ3RaQ6eum5D2opDDf65FXHTV0DabHT4Dko7wDqBorqQkWNdWnCH
        bksxmP29TttkvK+8OObuDtlfVmDnkfI=
X-Google-Smtp-Source: ADFU+vudVcare/m1HhBNr6YwiYi0XYVWc7IYalBtWImJhH4KvjiGeCh0eX3w4h7Z23fYoj1S+6BaxQ==
X-Received: by 2002:a63:b34d:: with SMTP id x13mr14895365pgt.317.1584821439202;
        Sat, 21 Mar 2020 13:10:39 -0700 (PDT)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id w4sm8137562pgg.2.2020.03.21.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 13:10:38 -0700 (PDT)
Date:   Sat, 21 Mar 2020 13:10:37 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fpga: dfl.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200321201037.GA7238@epycbox.lan>
References: <20200319212153.GA5093@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319212153.GA5093@embeddedor.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Mar 19, 2020 at 04:21:53PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/fpga/dfl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 4a9a33cd9979..74784d3cfe7c 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
>  	int open_count;
>  	void *private;
>  	int num;
> -	struct dfl_feature features[0];
> +	struct dfl_feature features[];
>  };
>  
>  static inline
> -- 
> 2.23.0
> 
Applied to for-next,

Thanks
