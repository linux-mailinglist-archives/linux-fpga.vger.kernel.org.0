Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9458675550
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2019 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfGYRWe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Jul 2019 13:22:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36841 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbfGYRWe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Jul 2019 13:22:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so23365393pgm.3
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2019 10:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eL1HSchY4smbgjXqlJbm9OwKjrtCybSa9ZhZ0bGd0qc=;
        b=DMdAJkJ9bCo2yCu66/pnGUpLF68vujLs1Fgcv1uvV7giNx8i1gmXynnRJoHBiUG6CL
         I1PXHTv6s8uOBjt99B/FwJ0fL9Mj39j9rJ5rh8Euaime9owOcTBt8KiDU2P+smYQJgI/
         qZa4zl2rmhsTQ4c5aDSpa4Xtlq2076xPg5gD18rtH713Ke/lT5ZvJXkD42Ug8QM/qr+I
         bnLAEoVW3x0HFNmZk0M4F11/yxKqUkA3gs3wivjAgjR66Z8fcIy5uXg4vrpbAgrB/CWY
         oLBWJ7uXdJi3a3y1uhH0YvTEFjDiU1UDeHd7bVFAv0Q4hF0+aeVMKeprDAfvBlHyaPjL
         DXaw==
X-Gm-Message-State: APjAAAVtoY8YA+/hWbRvFQW4WLq2TjF8MGOzEM6xtTbwCYYLPBvHW9Ja
        TnuyXpO289Jl1fRWKKs/rFfWYg==
X-Google-Smtp-Source: APXvYqw6g/t+kwkzMzCg95KnrFkBICauD8uaMQbuX807kZZ/ogEmop7p/DADMkENl73VKq/2OSWodw==
X-Received: by 2002:a62:5487:: with SMTP id i129mr18293770pfb.69.1564075353183;
        Thu, 25 Jul 2019 10:22:33 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id y10sm51485076pfm.66.2019.07.25.10.22.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:22:32 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:22:31 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/3] fpga: altera-cvp: Add Stratix10 Support
Message-ID: <20190725172231.GA9274@archbox>
References: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Thor,

On Thu, Jul 25, 2019 at 10:16:45AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
> Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.
> 
> Most of the CvP registers and their bitfields remain the same
> between both the older parts and the newer parts.
> 
> This patchset implements changes to discover the Vendor Specific
> Capability offset and then add Stratix10 CvP support.
> 
> V2 Changes:
>   Remove inline designator from abstraction functions.
>   Reverse Christmas Tree format for local variables
>   Remove redundant mask from credit calculation
>   Add commment for the delay(1) function in wait_for_credit()
> 
> V3 Changes
>   Return int instead of void for abstraction functions
>   Check the return code from read in altera_cvp_chk_error()
>   Move reset of current_credit_byte to clear_state().
>   Check return codes of read/writes in added functions.
> 
> Thor Thayer (3):
>   fpga: altera-cvp: Discover Vendor Specific offset
>   fpga: altera-cvp: Preparation for V2 parts.
>   fpga: altera-cvp: Add Stratix10 (V2) Support
> 
>  drivers/fpga/altera-cvp.c | 348 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 277 insertions(+), 71 deletions(-)
> 
> -- 
> 2.7.4
> 

this doesn't apply since I applied Carlos' patch 998c1de56dac7
("fpga: altera-cvp: Fix function definition argument") yesterday to

git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git

'for-next' branch.

Would you mind resending it on top of that and drop the extra dev_dbg()
for the offset in Patch [1/3]?

Sorry about that. Things are moving around a bit, but hopefully settle
down soon :)

- Moritz
