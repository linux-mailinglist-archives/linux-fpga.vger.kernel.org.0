Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37FB16AE6
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfEGTLp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 15:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGTLp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 7 May 2019 15:11:45 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE35206BF;
        Tue,  7 May 2019 19:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557256304;
        bh=wxpXfzeg30yJtwBVcZ2RBcfKvzzxvZGj2gBh+TKdTX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OCR6dZOs4P+GND4bvJzaCsljYD/F0uho8FZ+4Fq8u6UGz34YDf/GyQ85cvSrFw17l
         5kbbMsjJzKhNs8UaD6bvxK+WAORzsBtb5k2eQPp5S7m/NRjFIbaNSAXWd2a3vGKnji
         KDdj66SH73CtwcNwFFyE2DI4h4jgcNw2dIVmShRU=
Received: by mail-ed1-f52.google.com with SMTP id p27so4833657eda.1;
        Tue, 07 May 2019 12:11:44 -0700 (PDT)
X-Gm-Message-State: APjAAAW1OJGK+tbOJfqhyLj+UIw8Da7EvnEPcWy0Z/rsqcAvG/f0FHy/
        viXL4PLVzqXiWRiT4Q8mnkJwviM4y9hQUOy36Pc=
X-Google-Smtp-Source: APXvYqy8VJWtc2XAI3FPIFZGm2gZs0vdSYDJAB7WgpG8fhGAb0Uto6woRbO6Whyz8RVZTeoDDxa5nTSkJ7Sf+McNSBM=
X-Received: by 2002:a17:906:66da:: with SMTP id k26mr10524492ejp.292.1557256302802;
 Tue, 07 May 2019 12:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190507170257.25451-1-mdf@kernel.org>
In-Reply-To: <20190507170257.25451-1-mdf@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 7 May 2019 14:11:06 -0500
X-Gmail-Original-Message-ID: <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
Message-ID: <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
Subject: Re: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 7, 2019 at 12:03 PM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

>
> Fixes the following static checker error:
>
> drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> error: 'eemi_ops' dereferencing possible ERR_PTR()
>
> Note: This does not handle the EPROBE_DEFER value in a
>       special manner.
>
> Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/zynqmp-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index f7cbaadf49ab..abcb0b2e75bf 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>         char *kbuf;
>         int ret;
>
> -       if (!eemi_ops || !eemi_ops->fpga_load)
> +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)

This if statement also happens in fpga_mgr_states
zynqmp_fpga_ops_state(), so we'll need this fix there also.

>                 return -ENXIO;
>
>         priv = mgr->priv;
> --
> 2.21.0
>

Alan
