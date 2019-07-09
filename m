Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F167D62CDE
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Jul 2019 02:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGIAFa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Jul 2019 20:05:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45924 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfGIAFa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Jul 2019 20:05:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so8459706pgp.12;
        Mon, 08 Jul 2019 17:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYSKPajnikQfrdnXRZykFulg5ENG+KCQGBUGtfPGZlg=;
        b=XySjreBKv+XusN+hkcVisz9az8El9Zu66L6f9mfkraPNdKikw7BMMDAioD5TVC0fJI
         KnQf7tbBAmZB41FIaQRSUfoYi2Ct9rsrAVYbjBAAUOqHE71qDDL439VN3DKcEf7Rbfur
         aiQxmsyfdAjSH4RH18iLdyRPAZaMCJSR2yWRupqx9QF8Yo6BSgw1AGGPsNnYjkm8EQTt
         E3Oi5GOoYux9mihB+u4sZgjOvGbBEA5tcDN3z3I0O6bLXY/ujQCn/ierw+1OK2/Gk5Kp
         529sJG+QHblIgqJP9dG72BMd2E0/PXTMKC5tOFlg3P0CVGA5h/9ha9bbknBhkewMgzRg
         0HKg==
X-Gm-Message-State: APjAAAVbot9LRdohtFUoZMS+qBXXkIDuM8xZAEF+AGEmmDXJaRoN6aTU
        eNDYmQseW7nhapeHQTcz3wM=
X-Google-Smtp-Source: APXvYqw4OK/VNHzcsYf5IVMszz6XiUhKsoIQPlbh1mptNrGz8PLaicjkWYPvmUMoTQX4f7gMRu5fDA==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr27995286pjq.69.1562630729425;
        Mon, 08 Jul 2019 17:05:29 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:aba9:7dd5:dfa6:e012])
        by smtp.gmail.com with ESMTPSA id i6sm15938258pgi.40.2019.07.08.17.05.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 17:05:28 -0700 (PDT)
Date:   Mon, 8 Jul 2019 17:05:27 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mdf@kernel.org, stillcompiling@gmail.com, atull@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga-manager: altera-ps-spi: Fix build error
Message-ID: <20190709000527.GA1587@archbook>
References: <20190708071356.50928-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708071356.50928-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 08, 2019 at 03:13:56PM +0800, YueHaibing wrote:
> If BITREVERSE is m and FPGA_MGR_ALTERA_PS_SPI is y,
> build fails:
> 
> drivers/fpga/altera-ps-spi.o: In function `altera_ps_write':
> altera-ps-spi.c:(.text+0x4ec): undefined reference to `byte_rev_table'
> 
> Select BITREVERSE to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: fcfe18f885f6 ("fpga-manager: altera-ps-spi: use bitrev8x4")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/fpga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 474f304..cdd4f73 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -40,6 +40,7 @@ config ALTERA_PR_IP_CORE_PLAT
>  config FPGA_MGR_ALTERA_PS_SPI
>  	tristate "Altera FPGA Passive Serial over SPI"
>  	depends on SPI
> +	select BITREVERSE
>  	help
>  	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
>  	  using the passive serial interface over SPI.
> -- 
> 2.7.4
> 
> 
Acked-by: Moritz Fischer <mdf@kernel.org>
