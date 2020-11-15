Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602242B3871
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKOTTk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:19:40 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40306 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgKOTTk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:19:40 -0500
Received: by mail-pf1-f175.google.com with SMTP id w14so11325767pfd.7;
        Sun, 15 Nov 2020 11:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sCdUZDZ+Yqlofwx7LvAQagcvHYFaJ7VL6GaQVJUCgmw=;
        b=fh2pi5HURLkEPREU6WUpQ/yUTONclVFefEQbpt7y1aMt5qTj5FD206dB4onohFgneu
         SwCXUFfWYFnZscFeb+ZquZKOO+X02sckVQHzIKWm/6kXcVqKZ3AjBGe1ylAXtjsQEUS3
         SbI0NUYYrbX/LdOLK69LUpXPZCAQ9jeTAecY8IYBhCDmJUnMzZ026wAGHyD+sZT64bIL
         xEx/Z2rvSYmzSLILg6M8i8nKeqduwhrkN8evyvG5T191MnbGIhE8GHuiezyDsv1Z4T6u
         5Ypqj+IPSsGkqKxWgM8VF2U8sEFsZnzI/EpD6ypddbLbKQXs+WXxuYt5dmcgPSQF9TDl
         CUxw==
X-Gm-Message-State: AOAM533uFdQNmemmuQ2PKrtL1yyvbfvZs9zF7q40jJ1fFIdJHbxUfKUk
        0n+l28hUYXsD+IrohvbAnt0=
X-Google-Smtp-Source: ABdhPJwgOoemqmSL5lJTPYlkGeSwcThICkaIaXz2nnY4w8ScpmSzjidYtdQ7bLWu3EyV71h4lLEcfQ==
X-Received: by 2002:a62:7781:0:b029:18b:5c31:5c27 with SMTP id s123-20020a6277810000b029018b5c315c27mr11028704pfc.70.1605467978279;
        Sun, 15 Nov 2020 11:19:38 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e184sm16038199pfe.146.2020.11.15.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:19:37 -0800 (PST)
Date:   Sun, 15 Nov 2020 11:19:36 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 4/4] fpga: stratix10-soc: entend driver for bitstream
 authentication
Message-ID: <20201115191936.GA283592@epycbox.lan>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Nov 12, 2020 at 12:06:43PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Exten FPGA manager driver to support FPGA bitstream authentication on
Nit: Extend
> Intel SocFPGA platforms.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c..8a59365 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -185,7 +185,10 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	ctype.flags = 0;
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +		ctype.flags |= FPGA_MGR_PARTIAL_RECONFIG;
I think we had this discussion during the original review of the
stratix10-soc driver?

Wasn't the point of using the BIT() to not assume alignment of FPGA_MGR
flags and firmware structure?

The FPGA_MGR_* bits are kernel internal and can therefore change, it
would be unfortunate to end up in a situation where this breaks the FW
interface (assuming firmware uses the value in pass-through which it
looks like is what is happening).

> +	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
> +		dev_dbg(dev, "Requesting bitstream authentication.\n");
> +		ctype.flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
Do you want to change this to BIT(COMMAND_AUTHENTICATE_BITSTREAM) or
something like that?
>  	} else {
>  		dev_dbg(dev, "Requesting full reconfiguration.\n");
>  	}
> -- 
> 2.7.4
> 

Thanks,
Moritz
