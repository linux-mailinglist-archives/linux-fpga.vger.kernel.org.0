Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBF486D83
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Jan 2022 00:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbiAFXGp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Jan 2022 18:06:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiAFXGo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Jan 2022 18:06:44 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNOZO-1mlBJg2TjG-00Op6C; Fri, 07 Jan 2022 00:06:42 +0100
Received: by mail-wr1-f42.google.com with SMTP id i22so7644605wrb.13;
        Thu, 06 Jan 2022 15:06:42 -0800 (PST)
X-Gm-Message-State: AOAM532NV0tP2YTklhpGRTZuGjMsAKOxqGOJhAFeulsNFcojQlOuN6uA
        UNJzePoyg5UWA3iErYQLl2jJA0t7EGlEtBXtXTs=
X-Google-Smtp-Source: ABdhPJzMj6xVjmpcWy7uxAm1SDGENlV1LdeAPWTqBhyWgP/ta3nPzaU9HiVSHY5IhZUe4kUZxh+mOC7tbMBL6EE76QE=
X-Received: by 2002:a05:6000:16c7:: with SMTP id h7mr4945147wrf.317.1641510402182;
 Thu, 06 Jan 2022 15:06:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr> <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 18:06:35 -0500
X-Gmail-Original-Message-ID: <CAK8P3a0MfHbB8ZFuTJpbVwPLZ-9QY-MWRFGukW1S4rbBBuDRzw@mail.gmail.com>
Message-ID: <CAK8P3a0MfHbB8ZFuTJpbVwPLZ-9QY-MWRFGukW1S4rbBBuDRzw@mail.gmail.com>
Subject: Re: [PATCH 03/16] fpga: dfl: pci: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, hao.wu@intel.com,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jb3UUKeC73QXXLHG6BGQK8zdK3TrNekO/paL5Gh4SeHc4NGIos3
 ryzMcNHxpv7ykEcQy5/ZA2KuW3oCMi/4ZTgpW9dVGfeL0z4dkBGnSEJ285wJ3y1rZ3+aCUN
 +rsS0RFP9od8SF42ciHjtvWZMwcri5B/1hfCtZ287wfBtycFWXNPBPoL7SayC5pOeQLbx8v
 JXvPFkt1IMCScMd0chXgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxzSQ5etFBE=:9uEF7FH/8Bb3K5B7Tprhtt
 12fQ8+4kljbKzuh0VlrgRfqbf6LkP22HAZBECy7+gPeeAX1aP7xBpeVKE+DBfUGqjeKtwVVB8
 7oBa7hjUNpvEgBKvqr2tqCmkesYccqG+gzR6PRfIXIMNpOQJVmo6Frt4T1BjqvC1KLRzUFaCn
 +UHcBXuw7VNS8Tm1T5gDgf+wpary3hEQOyZxcW5hpG7K00FFenWJgOGKVhg59Qh5X1hwBEM5e
 AWhL3+loBHHs4YiUOThY5Nrg2H0W8FplBX+cYAwNYOyEOrc8kokDNBPIFcYJpfaOCpG4g4lCg
 BK8j4V7jGlts9FNLbNBc20Kqje9pMA0Pk1oHB2k+T0AgMAEitT8deGtr6nZVtikghsZjiHtvl
 66jaim20iVv1CvaPWZbXwsqoJP0e8zTZaKFQPlPyAZ+t9F3hcYiS1pM10id6b8X9dCObUEL/+
 GIxKpyUfGjNN4g9nDhjRahlh5y6txa+moCSAxSyL0eoiKuRMb/3AaXrIE6SNwJUFVe80bajuk
 yR1wRZ6GGGw/0tVvmORHd2OfWkMhM5zI3lII+FnI1h8AWhGX7MqByu8E7rmqSTiFWVpRY5bnD
 Tqn7Vo/L4WnwgEjCBvS7vhHbAtHLhaSiGuY6Qbfx8e8Wf7A5XyYyKWtn47TzqFcQaWiQl2zxZ
 JrBQBKdUX0Lp3OXlQJuJ4mBPElxIEPtiZqusARzQh17UmmVM6vQxDyOaWpuaZkeHVjgw=
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jan 6, 2022 at 4:49 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> A coccinelle script has been used to perform the needed transformation.
> It can be found in [3].
>
>
> It has been hand modified to use 'dma_set_mask_and_coherent()' instead of
> 'pci_set_dma_mask()/pci_set_consistent_dma_mask()' when applicable.
> This is less verbose.
>
> The explicit 'ret = -EIO;' has been removed because
> 'dma_set_mask_and_coherent()' returns 0 or -EIO, so its return code can be
> used directly.
>
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>

This is a correct conversion of the driver, but I'd prefer to keep this separate
from the pci-dma-compat series.

> +       ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> +       if (ret)
> +               ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
> +       if (ret) {
>                 dev_err(&pcidev->dev, "No suitable DMA support available.\n");
>                 goto disable_error_report_exit;

The code looks a bit suspicous, both the old and the new version. If the device
ends up on a bus that can only do 32-bit DMA, shouldn't it remember this and
make sure it only does GFP_DMA32 allocations for buffers that are passed to
the device?

        Arnd
