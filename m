Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B883257120
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Aug 2020 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgHaAKA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Aug 2020 20:10:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46645 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgHaAJ7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Aug 2020 20:09:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id 31so3336249pgy.13;
        Sun, 30 Aug 2020 17:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iucP1YZuWrUVKjxqd1bXpSN+6NlJ9Lp0LD1bL/fThsw=;
        b=gH+fLqW58xwri18XYvcehOVAHK2Tuhjc7dsy+jhiWpfjx7NNAIYsMonIViSgdE8cw0
         L8Pily16Xd0yzcPzkmfpIT64WJiyMZAzCDpWRoezaGZxm6Jbi93dSYduejIMz0QyFq5x
         LciQAG8T8a5TaHUaLoH941AvxeajPPM+12GUY9Gob9sk1jZmyFkTRuSrezRtlDlWM6V4
         nTM+k7TLKmg3pwAw5s3pbO6cL5V05sD3/5aiPZGw/QdJ5KofdtA4kWKj+8AdD1mR7boO
         Sr+5vtz3YvCQqd9Sz4dN3D6O2WrZjMXx4tbvZbOUQji5ilcMn1iVcGfjsmBXjxu5DczC
         bg4Q==
X-Gm-Message-State: AOAM5335HwyMnJrfR5KoDSnkqsyCfyBr6RuCP1FMwKerXQESrVkNHRLD
        qakCE+/b9ZwEuyVh57Tlpi4=
X-Google-Smtp-Source: ABdhPJzGEkah4QjovWTx4O9dQqzC6p7ZVByNOuKX28HvpeMaEXxCmulr6ZefC8TTw0dsOpockaLF1w==
X-Received: by 2002:a63:e018:: with SMTP id e24mr6219495pgh.175.1598832598485;
        Sun, 30 Aug 2020 17:09:58 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a6sm5270233pgt.70.2020.08.30.17.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:09:58 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:09:57 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 5/5] fpga manager: xilinx-spi: provide better
 diagnostics on programming failure
Message-ID: <20200831000957.GE7421@epycbox.lan>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
 <20200830163850.8380-5-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830163850.8380-5-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 30, 2020 at 06:38:50PM +0200, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
> 
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
> Changes in v2:
>  - also check for gpiod_get_value() errors (Tom Rix)
> ---
>  drivers/fpga/xilinx-spi.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 52aab5a1f0ba..824abbbd631e 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -195,7 +195,21 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>  			return 0;
>  	}
>  
> -	dev_err(&mgr->dev, "Timeout after config data transfer\n");
> +	if (conf->init_b) {
> +		ret = gpiod_get_value(conf->init_b);
> +
> +		if (ret < 0) {
> +			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
> +			return ret;
> +		}
> +
> +		dev_err(&mgr->dev,
> +			ret ? "CRC error or invalid device\n"
> +			: "Missing sync word or incomplete bitstream\n");
> +	} else {
> +		dev_err(&mgr->dev, "Timeout after config data transfer\n");
> +	}
> +
>  	return -ETIMEDOUT;
>  }
>  
> -- 
> 2.28.0
> 
Applied to for-next,

Thanks
