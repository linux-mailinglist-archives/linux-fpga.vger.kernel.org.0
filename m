Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534492BA249
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Nov 2020 07:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgKTG1Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 20 Nov 2020 01:27:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43620 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKTG1P (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 20 Nov 2020 01:27:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id u2so4337420pls.10;
        Thu, 19 Nov 2020 22:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSunvUGJaujt7yUjWo9uue1vsdmlgja9FozF8lkzkW4=;
        b=oKuKVOoEEba7sHKf8Qi8L9JMSPSBpHgzpk0xW29f4jP+l3XmdutUlbbJYtN6rWO2d/
         ff7FrHKqVcnYHnYz6UZSnXOCVgtMc63KE7Iau2dJ4cvYkmzvjthP5RiVwnOctDeDrSvD
         O+GBJ52q7bNOIsn2Nv/dWSDvQbvlTvAwjTYIWyXQvh6gigejrJDUPWRjlczDKOcyov5j
         aPm0W+MWNb0RrCz2y779AD/4zzVcSvXZZgRx7dgNkpmrIMCeK+hj1nf4RJcDXllGHQjB
         lFaNTNQ/hPwh/be1uY9pfWfzAvOj0l6W+i/+QHYu45iXuEU8N76WlkAutM/sloi6S8s4
         ftWw==
X-Gm-Message-State: AOAM531JeV/nsipTN778gNHlcfyQaslzzCyvcVwud325FIF50r5TI+63
        lxK1d5QCy7YxZbV/Ab2v86rJDUjuiCvWeA==
X-Google-Smtp-Source: ABdhPJwkBY42pVdpeyGTJEF+W7CkFS+TgoQrLcZo3TdkR6JZk4nDmp8f/4jyORkJDr3nd4Cy82554g==
X-Received: by 2002:a17:902:9f86:b029:d6:d25f:7ad8 with SMTP id g6-20020a1709029f86b02900d6d25f7ad8mr12344848plq.4.1605853633648;
        Thu, 19 Nov 2020 22:27:13 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id k6sm2273338pfd.169.2020.11.19.22.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 22:27:13 -0800 (PST)
Date:   Thu, 19 Nov 2020 22:27:12 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <X7dhwNFehhCRs7Ry@epycbox.lan>
References: <20201119082209.3598354-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119082209.3598354-1-davidgow@google.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi David,

On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> functions, it should depend on HAS_IOMEM.
> 
> This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> HAS_IOMEM.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
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
Do you think we can add a Fixes: tag for this?

Thanks,
Moritz
