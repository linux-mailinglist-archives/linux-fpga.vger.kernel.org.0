Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA87A2F834C
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Jan 2021 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbhAOSJH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Jan 2021 13:09:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbhAOSJG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 Jan 2021 13:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610734059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Md7vRoyiKJc0iq4tJJs8CQ7dxbz/DxlqmE3R+5lMtE=;
        b=PvYFd7SmWlpqLD7lYgcwLoH+VGztN5pNADlIoKbyCclM8NXHrKwNTUc3w1qr+jRP3/y02B
        Q1Y8Gxbevsjn2nm1DtQMqFAmoJdFil4JenwhFUu3vJ1ZB6tYQbbN95TJuWbhhDbyajLUPe
        OKx8bE0bCGsiSYs3MkoaDHQ6KtD7OgA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-OPnkcGFXN8Cky6jOSmZv-w-1; Fri, 15 Jan 2021 13:07:28 -0500
X-MC-Unique: OPnkcGFXN8Cky6jOSmZv-w-1
Received: by mail-qk1-f200.google.com with SMTP id 189so8805080qko.1
        for <linux-fpga@vger.kernel.org>; Fri, 15 Jan 2021 10:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3Md7vRoyiKJc0iq4tJJs8CQ7dxbz/DxlqmE3R+5lMtE=;
        b=C1qFud4srjIAjzTbUZU4sAHv/DDE/qkdoZOjFFqBKKvCek/UWYzvYH4W/csR6b/77N
         JZG0//okIuMRBOiKnxrc/c1FuKVKul162+dJq3IBKdgPkA69G/Iac7q76lNjfZEt7oBl
         sjim5wXEn1Xi2itH6V5xm5WAOv7+1cp4o9RRD90ghp0k8Hn3dzXsi0d5Zq+MqhUfXiil
         SNuPyqM7vF98HjgIbpknYxEASN/WxXTZgHlx89fCqv1nk2CdIf2ZrBIyFwbtW3Fl1A8k
         rxOJ2rD4YIXL16U8wmm+YbV4N0VRLTTAkBM3SaGenN9FfqOU7T88Pqrt5VeAYbZAsh1C
         9O3w==
X-Gm-Message-State: AOAM532cCFW01Khk2ejJE26mcWovnhYXFgw1eq5JLriOKAiOim4e1dOc
        fHk89FqioJaRPucThSF6sfWes52lQM21KragluPMGVJtny8leDT+iT9u937Nc5bIZCHscBF3WHs
        RXMLD9TtM589t9KvoDASQVQ==
X-Received: by 2002:ae9:d847:: with SMTP id u68mr13552523qkf.409.1610734048023;
        Fri, 15 Jan 2021 10:07:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxGGsdmnjkULss7tilHK1g+lYfiaHQlYY+K09kc6sxYHVqk6Jy1JquyFM9u53peKnWffQPag==
X-Received: by 2002:ae9:d847:: with SMTP id u68mr13552493qkf.409.1610734047725;
        Fri, 15 Jan 2021 10:07:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a203sm5516833qkb.31.2021.01.15.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 10:07:27 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: fpga: Add compatible value for Xilinx
 DFX AXI shutdown manger
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     git@xilinx.com, chinnikishore369@gmail.com
References: <20210115013431.27667-1-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2dd1a504-9bb7-3bdb-028e-7edd0ed99668@redhat.com>
Date:   Fri, 15 Jan 2021 10:07:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115013431.27667-1-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/14/21 5:34 PM, Nava kishore Manne wrote:
> This patch Adds compatible value for Xilinx Dynamic Function eXchnage(DFX)
> AXI Shutdown manager IP.

A multi patch set should have a cover letter.

Use git format-patch --cover-letter

> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> index 4284d293fa61..42fca058a5f4 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -7,13 +7,26 @@ changes from passing through the bridge.  The controller can also
>  couple / enable the bridges which allows traffic to pass through the
>  bridge normally.
Below is some wordsmithing to make the compatibility explicit and remove unneeded words
>  
> +Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
> +Softcore
is compatible with the Xilinx LogiCORE pr-decoupler.
> +
> +The Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
> +manages one or more shutdown managers / fpga bridges.
> +The controller can shutdown/passthrough the bridges which prevents

Delete 4 lines above.

The DFX AXI shutdown manager prevents

> +AXI traffic from passing through the bridge. The controller safely
> +handles AXI4MM and AXI4-Lite interfaces on a Reconfigurable Partition
> +when it is undergoing dynamic reconfiguration (DFX), preventing system

I don't know about the use of '(DFX)' here, above it is Dynamic Function eXchange'

Here it is dynamic reconfiguration, maybe just delete the '(DFX)'

> +deadlock that can occur if AXI transactions are interrupted by DFX
> +
>  The Driver supports only MMIO handling. A PR region can have multiple
> -PR Decouplers which can be handled independently or chained via decouple/
> -decouple_status signals.
> +PR Decouplers/AXI shutdown manager which can be handled independently
> +or chained via decouple/ decouple_status signals.
Being compatible, i don't think it is necessary to add to / change this section.
>  
>  Required properties:
>  - compatible		: Should contain "xlnx,pr-decoupler-1.00" followed by
> -                          "xlnx,pr-decoupler"
> +                          "xlnx,pr-decoupler" or
> +			  "xlnx,dfx-axi-shutdown-manager-1.00" followed by
> +			  "xlnx,dfx-axi-shutdown-manager"
>  - regs			: base address and size for decoupler module
>  - clocks		: input clock to IP
>  - clock-names		: should contain "aclk"

Adding an example similar to the existing would be helpful.

Tom

