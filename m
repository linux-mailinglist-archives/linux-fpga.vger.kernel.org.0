Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBC1FD901
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Jun 2020 00:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFQWio (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Jun 2020 18:38:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42402 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQWin (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Jun 2020 18:38:43 -0400
Received: by mail-io1-f65.google.com with SMTP id x189so4838389iof.9;
        Wed, 17 Jun 2020 15:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zvm6Wi/JhfHZije2TzVP/BE8Hn0bB8Py76ZIIBYPOgw=;
        b=Si4UXLksSwbPfgm16FNIn1VFO4N614aZ8ylouk8VSjyI6F2wXll++8Dvkso6CuCcIs
         tg1qXnBkeAyfHjBs3JiWsPLcmaS+2MGw+EffI/GRTjVbJOzPqAz0AB2jE3EhdwsQfJ0z
         ABOwbsJ/Z7IsROCf68liwapOMKCCbbhz6cuRFjj4CRobNdkaW65Q1pH0C3ZaOT5RI7yP
         lTIxHOh41pZ+IQAvXapGhQTLXlLJaG7x/xM+H6PFcXJV9sFGoi5iKiB153u4inlb5Hge
         QcpL7565Uc+zAV2Qh42Huk/jO6I+s/CB7XicboI/KYF0HwUt/TNZ3FkFESdycupF9YlP
         uZvA==
X-Gm-Message-State: AOAM531sTlHEJxCyFVSXGFweJrfkXhaB5XHb1C9UO8NyYMX2dKtnlgZm
        MuKB7NTN+/9iuOviDMs5RQ==
X-Google-Smtp-Source: ABdhPJwRjmmjDo55yNTup3etyMo8kIw88xo+I0teA6HCDNX/YZbUsYSz1qb0GmfH4mDQpVpYEEtbLg==
X-Received: by 2002:a02:29ca:: with SMTP id p193mr1530021jap.129.1592433522665;
        Wed, 17 Jun 2020 15:38:42 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t14sm488074ilp.73.2020.06.17.15.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:38:42 -0700 (PDT)
Received: (nullmailer pid 2967167 invoked by uid 1000);
        Wed, 17 Jun 2020 22:38:41 -0000
Date:   Wed, 17 Jun 2020 16:38:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: fpga: xilinx-slave-serial: valid for
 the 7 Series too
Message-ID: <20200617223841.GA2967136@bogus>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 11 Jun 2020 23:11:40 +0200, Luca Ceresoli wrote:
> The Xilinx 7-series uses the same protocol, mention that.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt     | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
