Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258C62F1A3B
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbhAKP4R (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 10:56:17 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37393 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbhAKP4R (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jan 2021 10:56:17 -0500
Received: by mail-pl1-f171.google.com with SMTP id be12so44842plb.4;
        Mon, 11 Jan 2021 07:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k/q6ghGfVX7aRpJrmdqiUQq3M7wvn3TgGk1yd7jRFY4=;
        b=f+gHvHwczaiPKNypEg/08szetmr2tsEiGbgp4lBYRLg5BoHoMoLZpdmD0Yxkrb6nT2
         NYWEjOp8FalqqJpgHRJWglgnHqpkzVv8RAp6g+McH0w2iwSLE0GkHS+qPPRRtn+4BfgZ
         jPHQ5xxm6oBF6IHKSWzd5ylzghdSA86Tifw73oCqEciUUNKAhoTm8Nrum8auUnMd21U3
         0XAnmsB7X0fOpy1Q7+XDukGixYdTUtrinkP6auUKR+6bR4rZR9C0Fs75SzFk6hWJ52f6
         UmmVbWV24dIVPZ6dEQr1DW0XKC8GQFB3MyREj9CwcqCD3CUzmZwob0hPe4EwvxLUMHQY
         SpgQ==
X-Gm-Message-State: AOAM533K0bYm0W3199nlItm0jy+B5h28WrsLw1mr4RxqL9PDvHZS7bJa
        zFLexEI22GSM+kjFMDER024=
X-Google-Smtp-Source: ABdhPJw/h92k1Ojnvsu1M8LaI6nhi4Ozo+JY0SeMDYwxnwMfh58dNhSXaiy/H6TsPZszB6bCBN2lTw==
X-Received: by 2002:a17:90a:ee94:: with SMTP id i20mr17913724pjz.185.1610380535942;
        Mon, 11 Jan 2021 07:55:35 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id v11sm20097308pju.40.2021.01.11.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:55:28 -0800 (PST)
Date:   Mon, 11 Jan 2021 07:55:25 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Message-ID: <X/x07V2WqhmkIMcr@archbook>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Lukas,

On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> capability") provides documentation to the FPGA Device Feature List (DFL)
Nit: Do you want to make this a Fixes: tag instead?
> Framework Overview, but introduced new documentation warnings:
> 
>   ./Documentation/fpga/dfl.rst:
>     505: WARNING: Title underline too short.
>     523: WARNING: Unexpected indentation.
>     523: WARNING: Blank line required after table.
>     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> applies cleanly on next-20210111
> 
> Moritz, Matthew, please ack.
> 
> Greg, please pick this doc fixup to your fpga -next tree on top of
> the commit above.
> 
>  Documentation/fpga/dfl.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ea8cefc18bdb..c41ac76ffaae 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,7 +502,7 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
>  Location of DFLs on a PCI Device
> -===========================
> +================================
>  The original method for finding a DFL on a PCI device assumed the start of the
>  first DFL to offset 0 of bar 0.  If the first node of the DFL is an FME,
>  then further DFLs in the port(s) are specified in FME header registers.
> @@ -514,6 +514,7 @@ data begins with a 4 byte vendor specific register for the number of DFLs follow
>  Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
>  indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
>  zero.
> +::
>  
>          +----------------------------+
>          |31     Number of DFLS      0|
> -- 
> 2.17.1
> 

Thanks for doing this, I was about to send that same patch myself.

- Moritz
