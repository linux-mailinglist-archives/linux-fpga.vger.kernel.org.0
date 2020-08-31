Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA525711B
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Aug 2020 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgHaAHr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Aug 2020 20:07:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45389 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHaAHo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Aug 2020 20:07:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id 67so3335861pgd.12;
        Sun, 30 Aug 2020 17:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dLIaEgSmpIPRM+QpJKB6VygfCR/Lez/lvI9vbxdOuo=;
        b=R4giZMs+Oubponj/t6mJMLlqlVgKYT7B3MJp2Ve+W6jNzQ3aawjbSHzxl7xN7764Gf
         WMeV4uqzknTaGHcFAth15uIqJonqk6e8OQD7Tv5pifEe1ljRmT6yVqqBEZarB+HjQ/VR
         g9PfBjY/cHSj8tvAZ778x0jvfzUYG99UzG3ay+8JKcVB6U6powGnW2FRMRSkMvOHuJMy
         Txsgrrxitw96w4Bqb+RT7riIgC4Mr2H/HBj1vk7Fr5RIicwWi4CEg2+ATwv49d1cEpSK
         ET5nAwlto8PsnBvQpQpfx+eHfzaQsLfId3k5ebcnfgpIlWBs7B2hpbR2/7g7h/N2WPfz
         yhpg==
X-Gm-Message-State: AOAM5322XFPP1Hy6BcTnbFU1zqKjEGECSmhMEFhN1dim4dMAuVXMcnid
        aGZpjqX4qBi5RDbACqceipM=
X-Google-Smtp-Source: ABdhPJym6EJzKUZnyv/CAVuDq43O7DyxXUJ1W8fAlcFWQyh2NOnZIefX0IIP9DViIOabx5g9gTshkQ==
X-Received: by 2002:a05:6a00:851:: with SMTP id q17mr7309191pfk.214.1598832463992;
        Sun, 30 Aug 2020 17:07:43 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u8sm5788366pfm.133.2020.08.30.17.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:07:43 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:07:42 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 3/5] fpga manager: xilinx-spi: fix write_complete
 timeout handling
Message-ID: <20200831000742.GC7421@epycbox.lan>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
 <20200830163850.8380-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830163850.8380-3-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 30, 2020 at 06:38:48PM +0200, Luca Ceresoli wrote:
> If this routine sleeps because it was scheduled out, it might miss DONE
> going asserted and consider it a timeout. This would potentially make the
> code return an error even when programming succeeded. Rewrite the loop to
> always check DONE after checking if timeout expired so this cannot happen
> anymore.
> 
> While there, also add error checking for gpiod_get_value(). Also avoid
> checking the DONE GPIO in two places, which would make the error-checking
> code duplicated and more annoying.
> 
> The new loop it written to still guarantee that we apply 8 extra CCLK
> cycles after DONE has gone asserted, which is required by the hardware.
> 
> Reported-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4:
>  - add Reviewed-by Tom Rix
>  - fix uninitialized variable
>    (Reported-by: kernel test robot <lkp@intel.com>)
> 
> Changes in v3:
>  - completely rewrite the loop after Tom pointed out the 'sleep' bug
> 
> This patch is new in v2
> ---
>  drivers/fpga/xilinx-spi.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 01f494172379..fba8eb4866a7 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -151,22 +151,29 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>  				     struct fpga_image_info *info)
>  {
>  	struct xilinx_spi_conf *conf = mgr->priv;
> -	unsigned long timeout;
> +	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> +	bool expired = false;
> +	int done;
>  	int ret;
>  
> -	if (gpiod_get_value(conf->done))
> -		return xilinx_spi_apply_cclk_cycles(conf);
> +	/*
> +	 * This loop is carefully written such that if the driver is
> +	 * scheduled out for more than 'timeout', we still check for DONE
> +	 * before giving up and we apply 8 extra CCLK cycles in all cases.
> +	 */
> +	while (!expired) {
> +		expired = time_after(jiffies, timeout);
>  
> -	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> -
> -	while (time_before(jiffies, timeout)) {
> +		done = get_done_gpio(mgr);
> +		if (done < 0)
> +			return done;
>  
>  		ret = xilinx_spi_apply_cclk_cycles(conf);
>  		if (ret)
>  			return ret;
>  
> -		if (gpiod_get_value(conf->done))
> -			return xilinx_spi_apply_cclk_cycles(conf);
> +		if (done)
> +			return 0;
>  	}
>  
>  	dev_err(&mgr->dev, "Timeout after config data transfer\n");
> -- 
> 2.28.0
> 

Applied to for-next,

Thanks
