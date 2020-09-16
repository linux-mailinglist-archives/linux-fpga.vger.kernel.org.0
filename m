Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5526CB47
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 22:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgIPUZQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 16:25:16 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39814 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgIPR1j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Sep 2020 13:27:39 -0400
Received: by mail-qv1-f67.google.com with SMTP id z18so3947042qvp.6;
        Wed, 16 Sep 2020 10:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJCUNLPCHA5UswIIcKLpjEqVhl2aUwRXkN/u1+wxk7M=;
        b=mkgykCO00dX22jV9ntI6cy2u8ahwbm9El2ttXKIW/wLTnyK/FPegrba8Z4IwXKb3Jp
         PTNygK/rEcXetuqVnStEWekjaIjg+QIuL3zrriz1C8N28I7c7fwrq7VLgO1SwoFECJHv
         HFbKAt3vhhRwVpKbsI91QqX+N5oor7676vvupKJNMmNtRp8fRL7bdHLjnrpePJ+94LOw
         Uv8ELqIA8FMe5n0fNV6/KUyDr+AGJaAaFic/t4Mr2v8h4PCKWbvO8/W0/KV1xXkFiU4/
         qktcfN+8IJ/vHQMO5CpaalsgUm4Q0qXCbkg/06k90bDxORNhbvWjWZ0McgFN1SQL5UHn
         0J0g==
X-Gm-Message-State: AOAM533hIkBO0XnMpRNP1lun8D05BZAHcJSvMR9IbUsen1G+qzI0JOYG
        Nq8k5nlpUYWlwcVa3bXwzbJGVErFsZ4=
X-Google-Smtp-Source: ABdhPJxriOPb0ENJjqil9Y1gPKCpCkw/RQ38C9t1wefnHhyv80tw1czZTr4RWQN5eE62dmu81NbTRw==
X-Received: by 2002:a62:36c7:0:b029:13e:d13d:a05f with SMTP id d190-20020a6236c70000b029013ed13da05fmr22804789pfa.37.1600272641585;
        Wed, 16 Sep 2020 09:10:41 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id p29sm14915069pgl.34.2020.09.16.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 09:10:40 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:10:40 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl: Make m10_n3000_info static
Message-ID: <20200916161040.GA1066896@epycbox.lan>
References: <20200916142536.28748-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916142536.28748-1-yuehaibing@huawei.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yue,

On Wed, Sep 16, 2020 at 10:25:36PM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/fpga/dfl-n3000-nios.c:392:23: warning:
>  symbol 'm10_n3000_info' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/fpga/dfl-n3000-nios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> index 5088f8f0e0cd..686813b59d33 100644
> --- a/drivers/fpga/dfl-n3000-nios.c
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -389,7 +389,7 @@ static int n3000_nios_init_done_check(struct n3000_nios *ns)
>  	return ret;
>  }
>  
> -struct spi_board_info m10_n3000_info = {
> +static struct spi_board_info m10_n3000_info = {
>  	.modalias = "m10-n3000",
>  	.max_speed_hz = 12500000,
>  	.bus_num = 0,
> -- 
> 2.17.1
> 
Can you resend this with a [PATCH v2] or [PATCH v2 next], neither
lore nor patchwork picks it up in its current form.

This'll make sure it doesn't get lost.

While at it could you change the first line to:

"fpga: dfl: n3000-nios: Make m10_n3000_info static"

Thanks for the patch,
Moritz
