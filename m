Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1B257115
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Aug 2020 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHaAFK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Aug 2020 20:05:10 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37228 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHaAFI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Aug 2020 20:05:08 -0400
Received: by mail-pj1-f67.google.com with SMTP id mw10so2080646pjb.2;
        Sun, 30 Aug 2020 17:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SpLFGYJAUXcKK7EXx9BKFsBSSfLkQA4HjyrtON3Ood0=;
        b=ZENJ6TwAUmX143PWNDJ3/DpXUgC3DuJeiijWvph4h+55IgZqf6CqK9AWihoIrX9zpV
         CvoxZukNzf4455MTLGfD9c30gLw1Qz8CRp747B3Nfd7zSTBbgpsyAwSvRSg4yUHeAS60
         rMbS9j/nRUNnqgwqhX89v5H2zpVNjOhMGBypO9XocoDLW+Bl1Z0a+JJILwzeICCAgYR4
         k17AJj2a+Nvi7lwMMVb+k5EtdckQqDOwGR2emZy5XQNie2RQlU5I4rwRFEB9oleMROEV
         Gl+67bFE5KWApCe0VmyoSZTxpHeFGrCMs/0GDhZC4cKKu1S1PIk70dBR6mApGHdNja8F
         OnAQ==
X-Gm-Message-State: AOAM530o02+5N4iOePPOCzbjH4VPykwoxXRitXZw2JI4x2cLedhJqorM
        yh1z1/PY1eHzzWNnTC5XYUIzb9fd1VI=
X-Google-Smtp-Source: ABdhPJxVXl8xL+AqpNQntrD33RPTLGDg3ka8E8TbMotHGW0ZNJPlq1OKHGFoZEtirrwdFuLCcf9aZg==
X-Received: by 2002:a17:90a:3e4f:: with SMTP id t15mr4299932pjm.19.1598832307907;
        Sun, 30 Aug 2020 17:05:07 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c5sm5624756pgj.0.2020.08.30.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:05:07 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:05:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 1/5] fpga manager: xilinx-spi: remove stray comment
Message-ID: <20200831000506.GA7421@epycbox.lan>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830163850.8380-1-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 30, 2020 at 06:38:46PM +0200, Luca Ceresoli wrote:
> Remove comment committed by mistake.
> 
> Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4:
>  - add Reviewed-by Tom Rix
> 
> Changes in v3: none.
> 
> Changes in v2: none.
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
Earlier version was applied to for-next (forgot-push) ...

Thanks,
Moritz
