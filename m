Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFFC25711E
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Aug 2020 02:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHaAJi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Aug 2020 20:09:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41167 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgHaAJh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Aug 2020 20:09:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id t9so3606148pfq.8;
        Sun, 30 Aug 2020 17:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lN4dhOfWGlPTNa10rF9hSSZrp74dJxZz+62rxmBUI/I=;
        b=Y7lvOSoe7d27UUhPwDwFjV5GKVlGcggcD8dDnNr2GEctKIn7lVlJb5fl6Z8HnxlnZi
         NVjR/qVBNc23r5uSSFptX//D669elM0U4jEkojw0WZlYz053d3yfzK3cpnsX2hJx1G5N
         Irk/RkBnSg0VOs+q4RHQFGU27SmvumA2Nnx1AlBb0j8CSsdflMQWXfoHD6UcRM/9bFVX
         I9jUnTNRhnZsslL1prH9iYAuWZh189ualoiB1g0ILf6/3Ssvp1jwz+i/0DT6ivlwswta
         TakesLjKgKH31sA5OIAmKfpRWAoF1ZwtFy7pJEQAdZQiiME0RMlbeBgvIjhMUmrJY9fh
         Urtw==
X-Gm-Message-State: AOAM531bhDGevTTE7NCbr6KRCFdhuPedR8Lekd1wlUQ3kuGDlSjeftqm
        lmXvbp571a7Xzmgshw8tXvmJZLd17kQ=
X-Google-Smtp-Source: ABdhPJxzfjymDZpuuLdmqX8QLsXJCX9wu2S/DsvIKDqq8txP+pGrpRgvBSB/+LJ/vfenVKCcDf6heg==
X-Received: by 2002:a65:6119:: with SMTP id z25mr6665066pgu.52.1598832576596;
        Sun, 30 Aug 2020 17:09:36 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 131sm5509486pgh.67.2020.08.30.17.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:09:36 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:09:35 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 4/5] fpga manager: xilinx-spi: add error checking
 after gpiod_get_value()
Message-ID: <20200831000935.GD7421@epycbox.lan>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
 <20200830163850.8380-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830163850.8380-4-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 30, 2020 at 06:38:49PM +0200, Luca Ceresoli wrote:
> Current code calls gpiod_get_value() without error checking. Should the
> GPIO controller fail, execution would continue without any error message.
> 
> Fix by checking for negative error values.
> 
> Reported-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4:
>  - add Reviewed-by Tom Rix
> 
> Changes in v3:
>  - rebase on previous patches
> 
> This patch is new in v2
> ---
>  drivers/fpga/xilinx-spi.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index fba8eb4866a7..52aab5a1f0ba 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -27,11 +27,22 @@ struct xilinx_spi_conf {
>  	struct gpio_desc *done;
>  };
>  
> -static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
> +static int get_done_gpio(struct fpga_manager *mgr)
>  {
>  	struct xilinx_spi_conf *conf = mgr->priv;
> +	int ret;
> +
> +	ret = gpiod_get_value(conf->done);
> +
> +	if (ret < 0)
> +		dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
>  
> -	if (!gpiod_get_value(conf->done))
> +	return ret;
> +}
> +
> +static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
> +{
> +	if (!get_done_gpio(mgr))
>  		return FPGA_MGR_STATE_RESET;
>  
>  	return FPGA_MGR_STATE_UNKNOWN;
> @@ -57,10 +68,21 @@ static int wait_for_init_b(struct fpga_manager *mgr, int value,
>  
>  	if (conf->init_b) {
>  		while (time_before(jiffies, timeout)) {
> -			if (gpiod_get_value(conf->init_b) == value)
> +			int ret = gpiod_get_value(conf->init_b);
> +
> +			if (ret == value)
>  				return 0;
> +
> +			if (ret < 0) {
> +				dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
> +				return ret;
> +			}
> +
>  			usleep_range(100, 400);
>  		}
> +
> +		dev_err(&mgr->dev, "Timeout waiting for INIT_B to %s\n",
> +			value ? "assert" : "deassert");
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -85,7 +107,6 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  
>  	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
>  	if (err) {
> -		dev_err(&mgr->dev, "INIT_B pin did not go low\n");
>  		gpiod_set_value(conf->prog_b, 0);
>  		return err;
>  	}
> @@ -93,12 +114,10 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  	gpiod_set_value(conf->prog_b, 0);
>  
>  	err = wait_for_init_b(mgr, 0, 0);
> -	if (err) {
> -		dev_err(&mgr->dev, "INIT_B pin did not go high\n");
> +	if (err)
>  		return err;
> -	}
>  
> -	if (gpiod_get_value(conf->done)) {
> +	if (get_done_gpio(mgr)) {
>  		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
>  		return -EIO;
>  	}
> -- 
> 2.28.0
> 
Applied to for-next,

Thanks
