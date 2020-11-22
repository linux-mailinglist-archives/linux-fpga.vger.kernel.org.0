Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1D2BC2D7
	for <lists+linux-fpga@lfdr.de>; Sun, 22 Nov 2020 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgKVASG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 21 Nov 2020 19:18:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33152 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgKVASG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 21 Nov 2020 19:18:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id t18so6958081plo.0;
        Sat, 21 Nov 2020 16:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0pPjDLS6VLvuxC5onraIQ2o57wzPveKWzsW70aJDNY=;
        b=dtVnyd2I+1pImf6aNLVXglkoaUnG6yQXhn2t71Kutjvy8Cou3mAZ+y7wnu5+/Z73kp
         HIoNAezem67P+NTulJClNK5yrpLFrYBExQa/xniFmmRpEZMqMqPQWazbxuJvgJXbTmA6
         MBWCvNN7dZnWX4YYdz2z0lie/Bx14Qb/Bm8TKbvm+C8BZUhttOxXyjZ3hKQUP2hYv9+D
         RDMRUy/9SxWp/9VuULvJMNdPchAyRfrzEWL9FDpH7x9+bJ754v6dVbQZoEFBXGMse/Es
         XmVxkD4LqwPtCeZtfFiVJesPaHQhwzurlLpT8vW4Fb/OFu9mkx5TMfaFEiyl7tH71sBp
         sVyg==
X-Gm-Message-State: AOAM532ceskVlKuIAMvebq5JkC4tm1yZUBgOLSz9b0j3877jh/XPwfvW
        8skF0KXV8tY6Xt70E4Y3pSo=
X-Google-Smtp-Source: ABdhPJwKnZ8ZFeHwlGIoZfe1NPZ41lvSD2uuhy9D/l189s3q4blm4nu2KaQ+A3uh2n3Fw0lM8lyZjw==
X-Received: by 2002:a17:902:b717:b029:d9:e816:fd0b with SMTP id d23-20020a170902b717b02900d9e816fd0bmr7902956pls.50.1606004291693;
        Sat, 21 Nov 2020 16:18:11 -0800 (PST)
Received: from localhost (c-73-235-149-126.hsd1.ca.comcast.net. [73.235.149.126])
        by smtp.gmail.com with ESMTPSA id v1sm8918721pjs.16.2020.11.21.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 16:18:11 -0800 (PST)
Date:   Sat, 21 Nov 2020 16:18:10 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2] drivers: fpga: Specify HAS_IOMEM dependency for
 FPGA_DFL
Message-ID: <X7muQm+0089dbLS9@archbook>
References: <20201120234648.4050910-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120234648.4050910-1-davidgow@google.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Nov 20, 2020 at 03:46:48PM -0800, David Gow wrote:
> Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> functions, it should depend on HAS_IOMEM.
> 
> This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> HAS_IOMEM.
> 
> Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v1:
> ( https://lore.kernel.org/linux-fpga/20201119082209.3598354-1-davidgow@google.com/ )
> - Add Fixes tag
> 
>  drivers/fpga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..5645226ca3ce 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -142,6 +142,7 @@ config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
>  	select FPGA_REGION
> +	depends on HAS_IOMEM
>  	help
>  	  Device Feature List (DFL) defines a feature list structure that
>  	  creates a linked list of feature headers within the MMIO space
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 

Applied to for-5.10,

I fixed up your commit message (dropped the drivers:)

- Moritz
