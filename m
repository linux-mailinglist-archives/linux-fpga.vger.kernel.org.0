Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CBA4BF11B
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Feb 2022 06:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiBVFUH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Feb 2022 00:20:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBVFUG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Feb 2022 00:20:06 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06213C384;
        Mon, 21 Feb 2022 21:19:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z4so16083980pgh.12;
        Mon, 21 Feb 2022 21:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22C4cVx+wwRK5mM3PpCccFYagn1VQQoWygpX53OoDD8=;
        b=Fitx7Rz21j0muIjVlHevlKW2uIPsKeArKu5llXn1ypgfZUWYeblPkj8+IjVwlSeIda
         MR5Grczq8OppWjGPao4gL65cjecUmuL/AnTrfCUBSioRltkbbWYavBPbyu3VXia7tlWp
         vJQwEQ7hlYZ0sQZkKXaUgz6Zxxyut1RdfVrxV1WrTjoJiGRQA4GO2OLfuUjzZXcUiICb
         IpFYLVxh+ir2TnUT2taTJRhqqdHflnmwmdMnSEr0vjYSjsuwXKgcxqNngo6pzN2PFe1t
         b8KBGJqfRVv/zPVgqdgt7f6SjxNq9PlB7NvPqKobDh6Bvg6opcXtoifeP1F/TjXtQvSL
         qDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22C4cVx+wwRK5mM3PpCccFYagn1VQQoWygpX53OoDD8=;
        b=uY9O/8mf8pJCyh7BAkBaHAjPVSmKHYOldIylLX3SJavGiaAAr+Tt7bZma6vug43SLw
         DG1QowSq+juRrB8WTbr9FvEfsnbvXNjG4VPUypmRFMvzta8SAIaPCJQrHZEzw0/GdBVV
         slh8AiTfHs7otzICe+5R0vIAweJ0R0uk+ui586gctYhG47/QP5t69BGUYL8xn+Y/dlNh
         r49nnUbkAHi8mnb/ssvbWtI+mX+1W21LjVb1VZHDd1531ZB4Hlfy2zLMAVsDWOqzPgBs
         hrywCpNdX5Szgch1Ela+EgB0t5ckUOkZJItAx3pvLw6apvDyrzLuQD+E1YyA6mZ2gZ7A
         uSTA==
X-Gm-Message-State: AOAM530o4GTls5piFL6N9acV80gLiu6iNT1Qxdax3bDHUz4Y6B0GBmOT
        F0LIZIuJTF9TRrHGI5d8o6b179wM09Xl1Srzh3GExWUnfRgDtQ==
X-Google-Smtp-Source: ABdhPJx2nohtO7sqA42Cth7WpO+cxFz9XNQYZr102InHpoyzE3whglzftuYg4H3A+RIjeTvFVPP9yl5SvJjbd37QQRQ=
X-Received: by 2002:a67:b34a:0:b0:31b:f0fd:fbe1 with SMTP id
 b10-20020a67b34a000000b0031bf0fdfbe1mr9156792vsm.9.1645504800565; Mon, 21 Feb
 2022 20:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20220222042700.385001-1-yusisamerican@gmail.com>
In-Reply-To: <20220222042700.385001-1-yusisamerican@gmail.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Mon, 21 Feb 2022 20:39:48 -0800
Message-ID: <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
Subject: Re: [PATCH -next] pga: dfl: pci: Make sure DMA related error check is
 not done twice
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, mdf@kernel.org,
        trix@redhat.com, hao.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Note: This bug was introduced here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6
I saw this commit inside the linux-next branch, it is not present in
the mainline branch.
The linux-next branch was last updated 5 days ago, so I am unsure
about the state of that commit.

On Mon, Feb 21, 2022 at 8:27 PM Yusuf Khan <yusisamerican@gmail.com> wrote:
>
> In the case that the DMA 64 bit bit mask error check does not fail,
> the error check will be done twice, this patch fixed that.
>
> NOTE: This patch is only for use in the linux-next branch as the
> commit that caused this bug happened there.
>
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/fpga/dfl-pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 717ac9715970..6222f18aed4b 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -356,11 +356,12 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>         pci_set_master(pcidev);
>
>         ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> -       if (ret)
> -               ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
>         if (ret) {
> -               dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> -               goto disable_error_report_exit;
> +               ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
> +               if (ret) {
> +                       dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> +                       goto disable_error_report_exit;
> +               }
>         }
>
>         ret = cci_init_drvdata(pcidev);
> --
> 2.25.1
>
