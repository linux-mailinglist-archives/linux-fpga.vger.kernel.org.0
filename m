Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EEA174E5B
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Mar 2020 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCAQWK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 1 Mar 2020 11:22:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40366 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQWK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 1 Mar 2020 11:22:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so3194074plp.7;
        Sun, 01 Mar 2020 08:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9koHcfE2byKYUurFST7R4fCRDBFWe2+HNIUcVvidVE=;
        b=eCzQ6fpJEEtWSQp2R110F4PFE5v2iaOVvWVUfJl86ye4sYsH9QebtOstGorS9ga7UU
         kwjeBZI5iTIKCX3X/0RqnUXpWOyl2zI/IJU1o65WMd/CiVVv4Eop7p2D6pmIBGTL98JF
         zC3ItHgvC9LKFUZDxbYx9/GVoKwpvUm1kKpkT3Zl2vgM7gb3r1YwL4IleN0LgpcZ54+5
         7eET0MkxYEhsYDyzniIlqsU1eTg3SIpYjf40O8DH1bBS4wVjlXyKNZzN4Ax0supCkqTB
         ETfKwSauT4bff2bX7Ds5HFpG/mi+S88GkxjF6MXCBwMi3Xyg1yvtYEe3VGHxC3dy89Qy
         vhHA==
X-Gm-Message-State: APjAAAWUYvNZlYx+jtca/yUnZhfcTYPVnQUBPHXvrUyhBgkxenMbsEbk
        IhZnVUsFsVn00/n5ZPh1L90=
X-Google-Smtp-Source: APXvYqxhf+/qjon77gwWZzZsyVcNKO5Z+PzjfjkCP6KY4zM/Cbdqzvd3SBMf32o8PbVbNp3mT3R0gQ==
X-Received: by 2002:a17:90a:c091:: with SMTP id o17mr14217982pjs.47.1583079729150;
        Sun, 01 Mar 2020 08:22:09 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id l21sm9113501pjt.7.2020.03.01.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:22:08 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:22:07 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        mdf@kernel.org
Subject: Re: [PATCH] fpga: ice40-spi: Use new structure for SPI transfer
 delays
Message-ID: <20200301162207.GB7593@epycbox.lan>
References: <20200227120932.12542-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227120932.12542-1-sergiu.cuciurean@analog.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Feb 27, 2020 at 02:09:32PM +0200, Sergiu Cuciurean wrote:
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
>  drivers/fpga/ice40-spi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 56e112e14a10..8d689fea0dab 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -46,10 +46,16 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
>  	struct spi_message message;
>  	struct spi_transfer assert_cs_then_reset_delay = {
>  		.cs_change   = 1,
> -		.delay_usecs = ICE40_SPI_RESET_DELAY
> +		.delay = {
> +			.value = ICE40_SPI_RESET_DELAY,
> +			.unit = SPI_DELAY_UNIT_USECS
> +		}
>  	};
>  	struct spi_transfer housekeeping_delay_then_release_cs = {
> -		.delay_usecs = ICE40_SPI_HOUSEKEEPING_DELAY
> +		.delay = {
> +			.value = ICE40_SPI_HOUSEKEEPING_DELAY,
> +			.unit = SPI_DELAY_UNIT_USECS
> +		}
>  	};
>  	int ret;
>  
> -- 
> 2.17.1
> 
Applied to for-next,

Thanks
