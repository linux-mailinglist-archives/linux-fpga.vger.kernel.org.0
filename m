Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D133EF833
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Aug 2021 04:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhHRCrz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Aug 2021 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhHRCrz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Aug 2021 22:47:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92071C061764;
        Tue, 17 Aug 2021 19:47:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qk33so1735138ejc.12;
        Tue, 17 Aug 2021 19:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JV9CkkXQherlLd92QHiaKdeY0xjPOTwuWMHEmwKi7Ik=;
        b=gH1o7HXUHZ9yBstJRfMaB5RBp6WJl/jOcZOajXqQbt1ZDgzlCLKHH1DppvQQqtuPWS
         rejnTSTM2WEpJVbaSWxMaha7MjFV14asN7I4thA4spu9fN9Jw7cg+ntHLicmmGp6oYu4
         Cn7sPAt+/IeeyE282KiQclwhcA9hMWvIJfUZMKRhGLxVwGcHhH/INVJVjC1VnoMChRIB
         7eDziLWZMJLyomKg5tRpAqTo24bN+rw1mc+WHgHz/RJNOEK0XPiy15ehVJ+gFbKELe0W
         kpYv/SzePNoKg6Xo5+fBszHkfkUbzw5w9sG3s7L/dK4P4DV6+geMCugHzoz66uxNzVj7
         dalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JV9CkkXQherlLd92QHiaKdeY0xjPOTwuWMHEmwKi7Ik=;
        b=BynuFHYI6VlVvQa0VetYs/1IVOxRbUckbiFfDXig21yuTHoPWPVl34PoCNhueryAkE
         AxdNUfzUP2sQEQ0OM6JdLN/S00+36LFFLJynuBltyqcHtxxcTOH9rWm33n607f+vFynV
         Tfm8FPCy5Q++h40uShGhI79dn3BvitpSgbitsF6aqCA146OvcU/aOjMG+muSSuU8wbM8
         BFKmwg91ZB2xqqeHECQUcVOJWIOhb8RAnxqzonqgMll90dLw8rnLEKuRbywj8D8iLcuP
         Y/sFNVH0JuNT8SHQ/PcwyDE3nBELa52ynq0bqkbt+Iix0dxyzrJlEO1gMMITKRleERK8
         o9ng==
X-Gm-Message-State: AOAM532+EZeWTKT3sBpct+kyIO1gKG6nIlTyQcOQkVilHM7pf3f9WqW8
        aWyrQfwZrzjQk3iCKLgC/2+1LwtkJwX0XuMnYd+zx40+
X-Google-Smtp-Source: ABdhPJzyDwm867lRUBPgAuAt04i4wPYwP0vaBVc+xjcq3tBlg2NRFh8g7VfCuQKbfDIVPKNHV8amMyUG3AQVCqOH/2o=
X-Received: by 2002:a17:907:2b09:: with SMTP id gc9mr7477125ejc.49.1629254840066;
 Tue, 17 Aug 2021 19:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <1628836842-82107-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1628836842-82107-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Tue, 17 Aug 2021 19:47:08 -0700
Message-ID: <CAJYdmeN5WHYx+mczUfkYbeWpRNwevDR5njxttW+4PuBw2Muf6w@mail.gmail.com>
Subject: Re: [PATCH] fpga: machxo2-spi: Fix missing error code in machxo2_write_complete()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Aug 12, 2021 at 11:41 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
>
> Eliminate the follow smatch warning:
>
> drivers/fpga/machxo2-spi.c:341 machxo2_write_complete() warn: missing
> error code 'ret'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 88fb3a002330 ("fpga: lattice machxo2: Add Lattice MachXO2
> support")
This shouldn't line-break.
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/fpga/machxo2-spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> index b4a530a..ea2ec3c 100644
> --- a/drivers/fpga/machxo2-spi.c
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -338,6 +338,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>                         break;
>                 if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
>                         machxo2_cleanup(mgr);
> +                       ret = -EINVAL;
>                         goto fail;
>                 }
>         } while (1);
> --
> 1.8.3.1
>

Applied to 'fixes' with modifications to commit message,

Moritz
