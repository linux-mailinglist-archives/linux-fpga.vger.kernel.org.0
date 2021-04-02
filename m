Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF14C352E11
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhDBRPm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 13:15:42 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:44865 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbhDBRPm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Apr 2021 13:15:42 -0400
Received: by mail-pj1-f45.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso2838452pjb.3;
        Fri, 02 Apr 2021 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvIP879InQBCjMJDIitep6BsYoi5bmmOhvQA8lKUHK0=;
        b=ghQVZOR0wFr7alCSqDXQfMSSle3qip09GvDsFMCKLdh1uwKaEDHoLLanYGV663odxi
         YfZVVLLW51W4o3Ow1ekUZkSnVGhWYf6pnkR0f3Q5UUp0UKh+lhhFGqEuhyk+BJK6NjRH
         Sqs6q9R96MWhjclGwEc21XqIZV5Q2VWes1wQIF52wj4BFXEVWUZfn5L1v7/FSA2/Tzl5
         npAhH48lYXn0fP2cvz8BZdpViIT4gcblPqFtdL4vw4mx9LhjEi9909IVIySs9pfs63K2
         JKBPmyn37FOx78tllrBpfonslB6P3EXfuw5zH+cgoZf9X8Y2T2RcSHeEio0uRwRfvOff
         JjOQ==
X-Gm-Message-State: AOAM531Oki4BZVpvb1kdO/x8hk9hvFHleyykmoKfZLedgmugtmB4LwZ+
        G5VrfE1vHCSgkNAQ3bG4Ywk=
X-Google-Smtp-Source: ABdhPJx+Hj0T3OLrIl0onRUSaCk9IlLMmDj6Vf6tZMxy/WkPxEEeOYtG2tzKgL5NnRcVVqiZhZ4hDg==
X-Received: by 2002:a17:90a:bb07:: with SMTP id u7mr14846496pjr.49.1617383739652;
        Fri, 02 Apr 2021 10:15:39 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q22sm7915406pfk.2.2021.04.02.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:15:38 -0700 (PDT)
Date:   Fri, 2 Apr 2021 10:15:38 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH 2/3] fpga: region: Add fpga-region property
 'power-domains'
Message-ID: <YGdROrOOzltI/Bbe@epycbox.lan>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092049.479-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 02, 2021 at 02:50:48PM +0530, Nava kishore Manne wrote:
> Add fpga-region property 'power-domains' to allow to handle
> the FPGA/PL power domins.
> 
> dt-bindings: fpga: Enable PM generic domain support
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf825019..969ca53bb65e 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -196,6 +196,20 @@ Optional properties:
>  - config-complete-timeout-us : The maximum time in microseconds time for the
>  	FPGA to go to operating mode after the region has been programmed.
>  - child nodes : devices in the FPGA after programming.
> +- power-domains : A phandle and PM domain specifier as defined by bindings of
> +	the power controller specified by phandle.
> +Example:
> +	fpga_full: fpga-full {
> +                compatible = "fpga-region";
> +                fpga-mgr = <&zynqmp_pcap>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +                power-domains = <&zynqmp_firmware PL_PD>;
> +        };
> +
> +	The PL_PD power domain will be turned on before loading the bitstream
> +and turned off while removing/unloading the bitstream using overlays.

Can multiple regions share a power-domain or is this specific to full
fpga reconfiguration?

- Moritz
