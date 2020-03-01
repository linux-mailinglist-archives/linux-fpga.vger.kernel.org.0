Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA01174E59
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Mar 2020 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCAQVy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 1 Mar 2020 11:21:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46429 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQVy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 1 Mar 2020 11:21:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so3184880pll.13;
        Sun, 01 Mar 2020 08:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsF1XC+a5Klfpkx+LTevpo0Y9W7KrFucGF2YFTk3yeU=;
        b=sNtyJxDhDUyYnJ3J8maRWWM6HknP0Uvoz9Gixz+hVyiaXU3tgUVDlx1TQMmxRlUXTp
         htiImewLtkNjwU3HyjmVaDBG1wFoUkPEmamx1dwa9WiNmZkCpYJd4q8LsAIKzlvzbnU7
         wz9BGf9NeJ5con8GfEXqB0zm/86UeQxfNT8HyV/l43z7/aOa/fDGY29iAEPCzZ6Ll5fr
         fF7IYPk1to3nsJ+0INlVL2yBqRamxVT6WMo7HZDoHO/ueWynAXO9ebVWKSv1ybtkYpOl
         KoN17D3P8JSHZOFfsUJkgIVDx2gIlUaaBkquKRqnzWcdAgpx6N3nyITgLaP46zCtjL0U
         vfTQ==
X-Gm-Message-State: APjAAAXFJ37hqQbCGC1b00BzQleL1k6FDhKBQocRdvcx9bqgVDt3AJu3
        flSu5mZ0SxUfXyUyMJ4IMQc=
X-Google-Smtp-Source: APXvYqyxAtJ4pkRjU89SN24DHKrHUReWUge8G120PQF1tT9VzZBHY7HksoHEpgV4NdePGIWsyhVCBg==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr13314893plm.69.1583079711929;
        Sun, 01 Mar 2020 08:21:51 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id c15sm16759320pgk.66.2020.03.01.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:21:51 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:21:49 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: machxo2-spi: Use new structure for SPI transfer
 delays
Message-ID: <20200301162149.GA7593@epycbox.lan>
References: <20200227142414.16547-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227142414.16547-1-sergiu.cuciurean@analog.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Feb 27, 2020 at 04:24:14PM +0200, Sergiu Cuciurean wrote:
> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current
> `delay_usecs` with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/fpga/machxo2-spi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> index 4d8a87641587..b316369156fe 100644
> --- a/drivers/fpga/machxo2-spi.c
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -157,7 +157,8 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
>  	spi_message_init(&msg);
>  	tx[1].tx_buf = &refresh;
>  	tx[1].len = sizeof(refresh);
> -	tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
> +	tx[1].delay.value = MACHXO2_REFRESH_USEC;
> +	tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
>  	spi_message_add_tail(&tx[1], &msg);
>  	ret = spi_sync(spi, &msg);
>  	if (ret)
> @@ -208,7 +209,8 @@ static int machxo2_write_init(struct fpga_manager *mgr,
>  	spi_message_init(&msg);
>  	tx[0].tx_buf = &enable;
>  	tx[0].len = sizeof(enable);
> -	tx[0].delay_usecs = MACHXO2_LOW_DELAY_USEC;
> +	tx[0].delay.value = MACHXO2_LOW_DELAY_USEC;
> +	tx[0].delay.unit = SPI_DELAY_UNIT_USECS;
>  	spi_message_add_tail(&tx[0], &msg);
>  
>  	tx[1].tx_buf = &erase;
> @@ -269,7 +271,8 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
>  		spi_message_init(&msg);
>  		tx.tx_buf = payload;
>  		tx.len = MACHXO2_BUF_SIZE;
> -		tx.delay_usecs = MACHXO2_HIGH_DELAY_USEC;
> +		tx.delay.value = MACHXO2_HIGH_DELAY_USEC;
> +		tx.delay.unit = SPI_DELAY_UNIT_USECS;
>  		spi_message_add_tail(&tx, &msg);
>  		ret = spi_sync(spi, &msg);
>  		if (ret) {
> @@ -317,7 +320,8 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>  		spi_message_init(&msg);
>  		tx[1].tx_buf = &refresh;
>  		tx[1].len = sizeof(refresh);
> -		tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
> +		tx[1].delay.value = MACHXO2_REFRESH_USEC;
> +		tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
>  		spi_message_add_tail(&tx[1], &msg);
>  		ret = spi_sync(spi, &msg);
>  		if (ret)
> -- 
> 2.17.1
> 
Applied to for-next,

Thanks
