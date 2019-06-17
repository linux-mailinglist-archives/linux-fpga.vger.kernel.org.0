Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527DC478AD
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Jun 2019 05:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfFQDfS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 Jun 2019 23:35:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfFQDfS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 Jun 2019 23:35:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so4872562pfd.2;
        Sun, 16 Jun 2019 20:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xf6/Wi7UEc9C3ULu2Qu1mtNXUj05B6UiEsqAT1yhjsE=;
        b=eKK+89zK9GntlqsnW1izR8XsLJ9kzRaT2h5PCvWF7E2JOd1dm06kdjsv8WYnlHST5c
         kwbSD/9r1WnmkzldQN/EpfkMTiu1FkMzUzeR9VWcmTf8aM0ATL0jIavX158lFWaZiz3f
         iQF53mhkClYRuB3UkO2tFYAgRVLxtGU2CpI7tElwL0y7rEZFKQHiCs9iQc/yz7eDkp0t
         g4BP6Hu95zdFxdULAai/U8Ze3F2umcE3UWckPBqvTjk6Ecu+1iDiLVweeWZeCoNWwwjj
         q5BTPTABUPMzuKzfWIvc0dz6AJLWXtDH9JHhCoQd0ymiujGY4vI93HVE9wnaSFg4BHdo
         630Q==
X-Gm-Message-State: APjAAAWSRieeXOim/mHXGJlflQ1ope9mLiR3zncfp+a56wqCN994hFE1
        KVu0n/SKY/M4cW7QK+BNBETr4O9ysfk=
X-Google-Smtp-Source: APXvYqyLg6Z68lBlkLWn4CSUJfU9qya4CjBwsXJ62+xMHkqBhPTw8vhxd/nbSyzdI4bbbkRvG1HfCw==
X-Received: by 2002:a62:1597:: with SMTP id 145mr3752630pfv.180.1560742517391;
        Sun, 16 Jun 2019 20:35:17 -0700 (PDT)
Received: from localhost ([2601:647:4700:b8cd:7726:b947:9a25:6e35])
        by smtp.gmail.com with ESMTPSA id m12sm6754149pgj.80.2019.06.16.20.35.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 20:35:16 -0700 (PDT)
Date:   Sun, 16 Jun 2019 20:35:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fpga: hand off maintainership to Moritz
Message-ID: <20190617033510.GA25342@archbook>
References: <20190617031113.4506-1-atull@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617031113.4506-1-atull@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Alan,

On Sun, Jun 16, 2019 at 10:11:13PM -0500, Alan Tull wrote:
> I'm moving on to a new position and stepping down as FPGA subsystem
> maintainer.  Moritz has graciously agreed to take over the
> maintainership.

Thanks a lot for all the work you put into this, it was good fun working
with you, and I hope you'll be back someday, or at least you'll keep
working on the Linux Kernel in other areas.

All: It'll take me a bit to get everything sorted, since I just switched
jobs and am still getting set up there, too, so please be patient :)

> Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80e2bfa049d7..448730982545 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6266,7 +6266,6 @@ F:	include/linux/ipmi-fru.h
>  K:	fmc_d.*register
>  
>  FPGA MANAGER FRAMEWORK
> -M:	Alan Tull <atull@kernel.org>
>  M:	Moritz Fischer <mdf@kernel.org>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
> -- 
> 2.21.0
> 

Cheers,
Moritz
