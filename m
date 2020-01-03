Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5F12F3F4
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Jan 2020 05:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgACE7G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Jan 2020 23:59:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42845 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACE7G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Jan 2020 23:59:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so18630889plk.9;
        Thu, 02 Jan 2020 20:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aI+2u/HpPBiuykMreYIKZGWs5PKmJVun0XNlugn6rAc=;
        b=CHHPPY+9q0N3Tle6VrCE1JCQ3wS+ROf23CNoSGVrX7gs4+uUqR/ysZWr0WA6EME1Fl
         QfO785HCs0PBLaVevL+IkfMkYKODs4tsTijNekJyqJv6DfFgYvxTmbYh6BB33JzcAHYV
         ePVsucS5NKdSuP4QRNr4zFeebB+VPCGBTVv1iJUAFsDho/4bKVMx8RUfEucaVYWhJwxa
         3pQLO37WN32xMRKSER81GOF0FwE7xNTLEkVnq3kGn6PfnVHi4Eo7fXVVAB9XUusQgy3R
         ZnbbKAcPd+tkIV2S81aa8kWqgdih452lAU7lE4YYBzOiIY68KWvVcPtF8PPcY3iMRVOS
         DjNA==
X-Gm-Message-State: APjAAAUqDJBvWecT3E4nCSWfKdjCo7BzecHieMj5fgmObIEi21BRw/TL
        NYBV8XiIY8jESq7gWJAoRhc=
X-Google-Smtp-Source: APXvYqw+LOTJQhZtHCaB+kTJjJDJIYZsr3DehvC+jKvor7K4ZfgEIQnO7Bcd6kEMP1QjxKXdUuS9hg==
X-Received: by 2002:a17:902:fe05:: with SMTP id g5mr90583596plj.3.1578027545630;
        Thu, 02 Jan 2020 20:59:05 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id 189sm67628996pfw.73.2020.01.02.20.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 20:59:04 -0800 (PST)
Date:   Thu, 2 Jan 2020 20:59:03 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: remove redundant dev_err message
Message-ID: <20200103045903.GA21472@epycbox.lan>
References: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 10, 2019 at 05:26:56PM +0800, Ding Xiang wrote:
> devm_ioremap_resource already contains error message, so remove
> the redundant dev_err message
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/fpga/ts73xx-fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index 9a17fe9..2888ff0 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -119,10 +119,8 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->io_base = devm_ioremap_resource(kdev, res);
> -	if (IS_ERR(priv->io_base)) {
> -		dev_err(kdev, "unable to remap registers\n");
> +	if (IS_ERR(priv->io_base))
>  		return PTR_ERR(priv->io_base);
> -	}
>  
>  	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
>  				   &ts73xx_fpga_ops, priv);
> -- 
> 1.9.1
> 
> 
> 

Applied to for-next.

Thanks,
Moritz
