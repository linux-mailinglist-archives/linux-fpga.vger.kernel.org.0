Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDC124AD8F
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Aug 2020 06:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgHTELN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Aug 2020 00:11:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34754 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgHTELM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Aug 2020 00:11:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id v16so451923plo.1;
        Wed, 19 Aug 2020 21:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jelrt2iE0YOKS7d/Ac3pVBTbS/TCz2oa2R5iJqNekE=;
        b=ixwB9b0NlW8aX7EGMzYVJ2eFuaG8/Wu/M5R9pPbV8p6Ri3vyKg4sf4VoKcnppB1F0C
         M9w8eXxdEpqsG0yArI6KnOBus756/B19UISXc6RMd622B+ZW7JQd2UxBgiR6YRFb5j8c
         CKfiuA4HHXpUHOdEGM/sjZaVIVfcBMWDz8LlZxqgDBFPJnP/Ak27NYPc2BdZ4J7C3BoI
         hZLvm+D5AguKiK0LvhrkxQHN+WTcn+nctjvPlxGfcXupmHxxKUpg+o7CpU/M0F5dXNOW
         HsoTfIB0+ZEDfP5fWZR5QKRXHRtUHpoQ3VuTpuWsoBF15Y2HREPJtFtu0SmbDmr4tgLq
         +Bzg==
X-Gm-Message-State: AOAM532ay9DVTPQOYe7AN2iRr3VUXfAttC1Vj4seGLs2ZpUT6rVKHLo4
        FNJdwvx8g2N6TcZwcvp4bu8=
X-Google-Smtp-Source: ABdhPJwndfVpHf63YhpLbuaU+SdHRPI1cyxMdBW0xoO6xFHpnlYZ8N8PtDWP2p55t/WXQe+yNCGfRA==
X-Received: by 2002:a17:90a:e551:: with SMTP id ei17mr909773pjb.224.1597896672013;
        Wed, 19 Aug 2020 21:11:12 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 196sm847592pfc.178.2020.08.19.21.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:11:11 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:11:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/3] fpga manager: xilinx-spi: remove stray comment
Message-ID: <20200820041110.GA4022@epycbox.lan>
References: <20200817165911.32589-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817165911.32589-1-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 17, 2020 at 06:59:09PM +0200, Luca Ceresoli wrote:
> Remove comment committed by mistake.
> 
> Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 2967aa2a74e2..502fae0d1d85 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -57,7 +57,6 @@ static int wait_for_init_b(struct fpga_manager *mgr, int value,
>  
>  	if (conf->init_b) {
>  		while (time_before(jiffies, timeout)) {
> -			/* dump_state(conf, "wait for init_d .."); */
>  			if (gpiod_get_value(conf->init_b) == value)
>  				return 0;
>  			usleep_range(100, 400);
> -- 
> 2.28.0
> 

Applied to for-next,

Thanks
