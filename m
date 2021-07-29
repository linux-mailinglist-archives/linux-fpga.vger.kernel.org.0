Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B513DAB14
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhG2Sj6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 14:39:58 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:36728 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2Sj6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Jul 2021 14:39:58 -0400
Received: by mail-il1-f170.google.com with SMTP id c3so6910027ilh.3;
        Thu, 29 Jul 2021 11:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8n24DYudmmBlwPEsIXvodH0cqEc+9JvYB6zqj+BSWA=;
        b=bbTg9xQcqeKr3I0czAlvIhs3OS0DnFY9++YElSx5zFNWZf72WtIPll0wmHpkMWcnI5
         rEgkZgL6PbRrkVxW0lQ8ntRKq+bKr7p4QPE+qsgso8V+HpC0rLWjGeDOD+okKQo3NP2p
         gPJDRi8sdhD7OIQuU5GKuR8ay3IC6STEmrrj1wY0kpMUTWWKtnNcu1hGfjP6iWDl4vXo
         IqGvopBqGcYZrSqiibm3gRvTDrE7V3dnxj4iNcY50i0ra8wIz7StZrW30apKKzPM91fv
         oSyVpJe5KKCZYK0wqHCq9NXZPEqECOCJDNvKlrXWrqo3CLYzus0IxwcmAgUd7ReezbTp
         rvdQ==
X-Gm-Message-State: AOAM5315q7ul+J9o3P+tLly42VFXw0IKCoG5MS6NqlPX/IK4dppTyQuL
        wCOcZ/t7ZwMaSoZs2s6IrA==
X-Google-Smtp-Source: ABdhPJzHZZglPsN0icIN4InIO/S2YvyIIh/Lyvd63Ouq0Q3WHZDfaRAcbLEDefewEG0ysVBx3EdK0Q==
X-Received: by 2002:a05:6e02:e82:: with SMTP id t2mr4721387ilj.218.1627583994765;
        Thu, 29 Jul 2021 11:39:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g1sm2356621ilq.13.2021.07.29.11.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:39:54 -0700 (PDT)
Received: (nullmailer pid 659539 invoked by uid 1000);
        Thu, 29 Jul 2021 18:39:52 -0000
Date:   Thu, 29 Jul 2021 12:39:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-fpga@vger.kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, trix@redhat.com, navam@xilinx.com,
        linux-arm-kernel@lists.infradead.org, mdf@kernel.org
Subject: Re: [PATCH v2] dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings
 to YAML
Message-ID: <YQL1+JfwKukG6E7j@robh.at.kernel.org>
References: <20210716212621.286806-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716212621.286806-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, 17 Jul 2021 06:26:21 +0900, Nobuhiro Iwamatsu wrote:
> Convert FPGA Manager for Xilinx Zynq MPSoC bindings documentation to
> YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> ---
> v2:
>   - Fix to the correct maintainer 'Nava kishore Manne <navam@xilinx.com>'.
>   - Update the word from configuration to Configuration.
> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 -------------
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml  | 36 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> 

Applied, thanks!
