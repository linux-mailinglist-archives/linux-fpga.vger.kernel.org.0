Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9ED9BF50
	for <lists+linux-fpga@lfdr.de>; Sat, 24 Aug 2019 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfHXSlt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 24 Aug 2019 14:41:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41941 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfHXSlt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 24 Aug 2019 14:41:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so7833811pgg.8
        for <linux-fpga@vger.kernel.org>; Sat, 24 Aug 2019 11:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSuVLTI0onJLfu3gp/vEaHHc7h5yJt6US9JDWx7JKa0=;
        b=rTrQjvINmrCWnNrhVdEw7rQv2ZGYsqxShgurlP/RYQz+GCAnUiuCuu7ZMgh3yQFpFL
         Cl1Fz1CifnA5t93gTPNCjZJx+LZVoBoR5X2Am+K5TClFF7vbCTwnkcLrzJm8PJkjOFFv
         2YpFZ8BkvcBngYphU9fNmE9e2K8k33wqmKG8ldPYj7q5Uw0gPlMHmPRHVo/N3xAn8ZlW
         e262MD4zxLxL/5EDontt8GAHPtmNr12BLOIckfbGsIg5SA9BE6BbiJcSUZlzU9W8yYX1
         yopnckK/R/yYn17onOye5gSh/vwpbqCFK7QUF9HXjvk2K27aPHSzY/UqLLNSXHKFnGSU
         pEeQ==
X-Gm-Message-State: APjAAAU9RSvp3xHTFJwvGXpi5cZ99KM2yUnJUNAe9WtdpUbeHmjOtTsz
        alOaWzuwgUh8wRqLiQ1iu7xtNQ==
X-Google-Smtp-Source: APXvYqwSkuq5leKgzEmlCl+2ZE690hz4vBXdTXbt48rpARtKdrGGqPgzG1p3WrzU7mJM0UNYD3NQlQ==
X-Received: by 2002:aa7:90c9:: with SMTP id k9mr11489616pfk.171.1566672108421;
        Sat, 24 Aug 2019 11:41:48 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id a189sm7105980pfa.60.2019.08.24.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 11:41:47 -0700 (PDT)
Date:   Sat, 24 Aug 2019 11:41:46 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCHv4 0/3] fpga: altera-cvp: Add Stratix10 Support
Message-ID: <20190824184146.GA12399@archbox>
References: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Thor,

On Mon, Aug 19, 2019 at 03:48:05PM -0500, thor.thayer@linux.intel.com wrote:
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
> V4 Changes
>   Rename delta_credit to space
>   Simplify wait for credit do-while loop.
>   Change from udelay() to usleep_range()
>   Use min() to find length to send
>   Remove NULL initialization from private structure
>   Use #define for Version1 offsets
>   Change current_credit_byte to u32 sent_packets.
>   Changes to Kconfig title and description to support Stratix10.
> 
> Thor Thayer (3):
>   fpga: altera-cvp: Discover Vendor Specific offset
>   fpga: altera-cvp: Preparation for V2 parts.
>   fpga: altera-cvp: Add Stratix10 (V2) Support
> 
>  drivers/fpga/Kconfig      |   6 +-
>  drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 271 insertions(+), 74 deletions(-)
> 
> -- 
> 2.7.4
> 

Applied to for-next. If all goes well I'll send it out with next PR.

- Moritz
