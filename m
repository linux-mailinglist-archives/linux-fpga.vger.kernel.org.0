Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95432470D5
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Aug 2020 20:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390332AbgHQSPr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Aug 2020 14:15:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55382 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390659AbgHQSPR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 Aug 2020 14:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597688110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g80cYW2IFYoqF9vli22IsbwtpI2QtdO1qkGnkN211CA=;
        b=hbDBU3LosV6oTd9neYg+r7CeAB21N+tyyWiLK6/krNhAN+wWzyfI9T+/vy2nl56dwPN1fJ
        9vAs1RN2s+lqpip6S++rhw0Ni/vnpJXh+bsbJ+bAmFY8mMKF1DXoQqaAYq7KHlipuTDFn2
        d+tL9pGBUCSThGdeSrKndALCqp5P1V8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-gIooqod4NXyOSckPbtQE3Q-1; Mon, 17 Aug 2020 14:15:07 -0400
X-MC-Unique: gIooqod4NXyOSckPbtQE3Q-1
Received: by mail-qv1-f70.google.com with SMTP id h6so11469550qvz.14
        for <linux-fpga@vger.kernel.org>; Mon, 17 Aug 2020 11:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g80cYW2IFYoqF9vli22IsbwtpI2QtdO1qkGnkN211CA=;
        b=NlRJZRRNh2R04p2nEHft75X1PPX9vgu52GVXjodadfUrMfPdxIrMyZZ8IOWs6oCk1T
         CaR6n6mGpYF0miAsfJXnyusYmtHKNEP8OHHdORhh0eJlW94AiqdJWO+WfYvrb2TdxkeJ
         x4hwJuu9lKzU30ayUeLyM24FoM6cyX91xoD5wSRPS9l4TMqUeNf+F2nraIbR+1I21mlG
         3yIivCUBwdgGNxzkSf7Buzixq6cepGKMlhrbob3jstcjZpDoC0ZbJI4DmMyVhdaYRRsF
         AmT5jXfX9ymugFanLcytTDH/9fXwwjauwmbUUNBZvHPBU/EIVXw4RaOknCZ2aKpJwezA
         kSkQ==
X-Gm-Message-State: AOAM530sRmNCwjQMDgyuTEW3W+XTimEj9UrdheKGCcYrlYGIF8EKtgcg
        7h5uQEsK5/2eMs6fI5vXeh3+v82HVmYfuAKyrULta9cztb87G4z1bBJINMks7RJwbEtLWgLEUbz
        J1JgWt6UFM1JksUroOzFooA==
X-Received: by 2002:aed:2f84:: with SMTP id m4mr14446127qtd.61.1597688106680;
        Mon, 17 Aug 2020 11:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXUfqFuGv20cuhSCCCZGpqoNHsGaqjHh4vKhxtI6LiZdZbnvJveBje9ZvXIG7CvZAAvbAeOw==
X-Received: by 2002:aed:2f84:: with SMTP id m4mr14446091qtd.61.1597688106092;
        Mon, 17 Aug 2020 11:15:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s184sm18253320qkf.50.2020.08.17.11.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:15:05 -0700 (PDT)
Subject: Re: [PATCH 2/3] fpga manager: xilinx-spi: provide better diagnostics
 on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200817165911.32589-1-luca@lucaceresoli.net>
 <20200817165911.32589-2-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b1a1a9d9-d36b-40f0-24e3-f793e55db929@redhat.com>
Date:   Mon, 17 Aug 2020 11:15:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200817165911.32589-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The other two patches are fine.

On 8/17/20 9:59 AM, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 502fae0d1d85..2aa942bb1114 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -169,7 +169,16 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>  			return xilinx_spi_apply_cclk_cycles(conf);
>  	}
>  
> -	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
> +	if (conf->init_b) {
> +		int init_b_asserted = gpiod_get_value(conf->init_b);

gpiod_get_value can fail. So maybe need split the first statement.

init_b_asserted < 0 ? "invalid device"

As the if-else statement is getting complicated, embedding the ? : makes this hard to read.  'if,else if, else' would be better.

> +
> +		dev_err(&mgr->dev,
> +			init_b_asserted ? "CRC error or invalid device\n"
> +			: "Missing sync word or incomplete bitstream\n");
> +	} else {
> +		dev_err(&mgr->dev, "Timeout after config data transfer.\n");
patch 3 removes '.' s , and you just added one back in ?
> +	}
> +
>  	return -ETIMEDOUT;
>  }
>  

Reviewed-by: Tom Rix <trix@redhat.com>


