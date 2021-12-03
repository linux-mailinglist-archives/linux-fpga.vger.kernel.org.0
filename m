Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA6046710A
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Dec 2021 05:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbhLCENj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Dec 2021 23:13:39 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:34497 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbhLCENi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Dec 2021 23:13:38 -0500
Received: by mail-pj1-f44.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so4382554pjb.1;
        Thu, 02 Dec 2021 20:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dUl5HdkR0eg9y5QTrryCRoApnzLb7oQF9XjkHY42JI=;
        b=eSPsSUI+KMFMsiNqpUzstvZgxvAIYPMfu6lFFt1hwjFNeWS1BwJbegEz2lbaFsy8qZ
         iC7aeGKawxUobUuDac4skPlBheHKdUjhv+ZdVa9Y8cV3GGBxlh9U6wo9MzkbVCbW0A4v
         iziWql5plrNVCvQ9AU7biYuVvtpjmciU95ID9X+CMgsIMJo0bdOLGz8bjWROLmMwBa7R
         VUrlRo2kJVe7nkUeninrqMe6L/erV6aPye4pe7kidnC+T1Gb5nwE/VDr4uosfWomsnwZ
         kj6eAyFfJZ8YX8Fy11fXGJFCSrWTuz+HxbWQkCm7OAFllwJFki5kbX8XVzVk91A2jMRw
         vD3g==
X-Gm-Message-State: AOAM5331ADj+3f13FDApjF5eRFCXbLDjZo7qictN4S2dNTrzdfdmGtW6
        Zf1A+u6izmrQ5ktjHZN43ITENWnNy7o=
X-Google-Smtp-Source: ABdhPJxOeK4PB48yR/W31gTuD6Tzw65ltOta9S3mIcP+awksWAaaFA/W1yPncC3RXIPSPnxYeosDXA==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id cx12mr11004583pjb.11.1638504614892;
        Thu, 02 Dec 2021 20:10:14 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id mi14sm3809367pjb.6.2021.12.02.20.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:10:14 -0800 (PST)
Date:   Thu, 2 Dec 2021 20:10:13 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2] fpga: stratix10-soc: Do not use ret uninitialized in
 s10_probe()
Message-ID: <YamYpQfrGcfuOBsa@epycbox.lan>
References: <20211130221123.3800420-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130221123.3800420-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 30, 2021 at 03:11:24PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/fpga/stratix10-soc.c:431:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>         return ret;
>                ^~~
> 
> ret is only assigned in an error path now so just return 0 directly.
> 
> Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1517
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20211129161009.3625548-1-nathan@kernel.org/
> 
> * Drop clang's suggestion text (Tom).
> 
> * Pick up Russ and Tom's review tags.
> 
>  drivers/fpga/stratix10-soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 737d14c6e0de..357cea58ec98 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -428,7 +428,7 @@ static int s10_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, mgr);
> -	return ret;
> +	return 0;
>  
>  probe_err:
>  	stratix10_svc_free_channel(priv->chan);
> 
> base-commit: 8886a579744fbfa53e69aa453ed10ae3b1f9abac
> -- 
> 2.34.1
> 
Applied to for-next,

Thanks
