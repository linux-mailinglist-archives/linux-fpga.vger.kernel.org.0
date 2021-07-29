Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1633DAB71
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhG2S4Y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 14:56:24 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:36409 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhG2S4Y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Jul 2021 14:56:24 -0400
Received: by mail-pl1-f173.google.com with SMTP id i10so8089120pla.3;
        Thu, 29 Jul 2021 11:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZz6/zHGUZj0w4zzvD5XxkPjFsO7iiACq/aqBQfXYfY=;
        b=hWS0IF2BeY6WCeTwBgYXcevV+Tj5FARbbaHVFvWkaQ9quPNV1aL39Pf6hQW7eVDCqs
         LD0Spg2UT1lnfE3lKxUytAgKurjUDbPfY/zpE55LNkqvE0KoH9+sWc0dzWxbZCYysT+5
         3auPsku6h7jCQEK71Guv8nuUFKNdkNLUbn16Uvh/OCdCVs4PfF51EHklqcIl7wHr42ol
         p3UHmNNRvHUjIQyMevIF9qJfH+ld99DVKsPWi8DrCbdyG4tPxxFovpInL0C4F7B7uVCG
         tynNqQWu0NlmhVMb/D/lbz+AGnSWBUR3EDExeBCSFZeatIulZ2/WYXtvTDX7I6ngr46O
         FxmA==
X-Gm-Message-State: AOAM53207afvwRp2+28XOOFDi4qNlmHoEW1hJkCqORvHZdErb0e/fd7y
        arY/aFofW1+Vji9II4BoMsM=
X-Google-Smtp-Source: ABdhPJzqPWAA/c+5+2iWGXnZ9kzG9DQCVPBhatZ4/Uv0WZh6q7/W4S9GrrJZkcLiwjUoX154ziQGYg==
X-Received: by 2002:a65:52c2:: with SMTP id z2mr5051930pgp.225.1627584979766;
        Thu, 29 Jul 2021 11:56:19 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id y7sm4109211pfi.204.2021.07.29.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:56:19 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:56:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Colin King <colin.king@canonical.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: Fix spelling mistake "eXchnage" -> "exchange" in
 Kconfig
Message-ID: <YQL50nVGliJu36ZR@epycbox.lan>
References: <20210728215150.191914-1-colin.king@canonical.com>
 <5e7b2e4a-aaf6-81f2-2b08-5a9adcbbee57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7b2e4a-aaf6-81f2-2b08-5a9adcbbee57@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 28, 2021 at 04:17:43PM -0700, Tom Rix wrote:
> 
> On 7/28/21 2:51 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in the Kconfig text. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   drivers/fpga/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 16793bfc2bb4..991b3f361ec9 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -119,7 +119,7 @@ config XILINX_PR_DECOUPLER
> >   	depends on HAS_IOMEM
> >   	help
> >   	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
> > -	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
> > +	  or Xilinx Dynamic Function eXchange AIX Shutdown Manager.
> >   	  The PR Decoupler exists in the FPGA fabric to isolate one
> >   	  region of the FPGA from the busses while that region is
> >   	  being reprogrammed during partial reconfig.
> 
> Looks good, thanks
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
Applied to for-next,

Moritz
