Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF62274F9
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jul 2020 03:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgGUBue (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jul 2020 21:50:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45537 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGUBuc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jul 2020 21:50:32 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so19703047iof.12;
        Mon, 20 Jul 2020 18:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z0RtKcdyckbxGpXUZiPyULk/wC7VcBbNcE6b2WWP54w=;
        b=ENhG0AQfCSisUHyr38D4GFmPIsuYwMsD6cJVwSA9nQIGSVj5wHu6yLMhwuQ3u1M6it
         vNRAiQMU5T38w0PWDdAq/bNr+miZdJTSvcQfX+2X+WBQE/3HvZye7LCkky8vVpix1mIt
         TKQHs5zk5ElxZfb0+3rAyN7PIcPrjfi7hsQW7eDUmcQ/BYl5GLgI/kK517RgfP/x8/n3
         HmeUizTKRijC9T6xHpJ64Dsdy2srppRX2sX9t7lOUHi2nsmVeO1RzURZ28m79X3wUyTS
         NuuJY9L3lT8nS/ZXl5t78i5wJV1YQSAIP31RUmWOtP4f8lfyCE52i0G+ExEOghWWkKfG
         J6jg==
X-Gm-Message-State: AOAM531tZr9wa01ZfIRg0/f6G1lDs8/6LN9ALIJjL3xaDqIFPMSQXKfZ
        FEx4s1lI3QQqyoClLy1OBqlAC2Zlow==
X-Google-Smtp-Source: ABdhPJzw06llVzkYmXpskxvWBiqRX9FwFqisQCpl8aErcTHmJfS/t6vIgGR48kFPGf7Gp6hqg/4niA==
X-Received: by 2002:a6b:d301:: with SMTP id s1mr25337667iob.146.1595296231874;
        Mon, 20 Jul 2020 18:50:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b14sm10027977ilg.86.2020.07.20.18.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 18:50:29 -0700 (PDT)
Received: (nullmailer pid 3358581 invoked by uid 1000);
        Tue, 21 Jul 2020 01:50:27 -0000
Date:   Mon, 20 Jul 2020 19:50:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        mdf@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] fpga: region: Replace HTTP links with HTTPS ones
Message-ID: <20200721015027.GA3358506@bogus>
References: <20200713134008.34635-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713134008.34635-1-grandmaster@al2klimov.de>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 13 Jul 2020 15:40:08 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
