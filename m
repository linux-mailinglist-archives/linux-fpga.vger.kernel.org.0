Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5492E32F3B3
	for <lists+linux-fpga@lfdr.de>; Fri,  5 Mar 2021 20:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCETST (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 5 Mar 2021 14:18:19 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45681 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCETSE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 5 Mar 2021 14:18:04 -0500
Received: by mail-ot1-f54.google.com with SMTP id d9so2824505ote.12;
        Fri, 05 Mar 2021 11:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XoHLnRJYg9VMpQurrAdrPVpbRFct8dLdoanWvg6YdwY=;
        b=E30Hy19HCtsMNt9dTNOqBSe9VXgZV/t3ZbUPEPgj2AerIV2FhpfNnHlDJTNI047HUo
         PB85atOXojZVupkCYC08V3++Elpfc616caA3XivhL1yAOt66rOyBatIokddt6sN2kARj
         /qgVrVx0ebsN/vUACpeuUe1myfoxhiXd7zgO4mUSDaDYm1xVkd9WE2HiOrPT1i5h4Hrp
         MePY0MWqN6YwMUyPLD/qDaj3JS229hRa4nUksh7VOFmyI/9sbGDJhSq4tT1qwD/VU4LO
         7h/6sy5tPc9FDPXa0ZTWmtUxo99hGMxSyctQgHAnfaE26peHypu67kyJFxcH9a1tbD4m
         QDzQ==
X-Gm-Message-State: AOAM5303Cmy9patPGcjsI+p+fogCIG2wtd3jmuV5rrCiSSaNCJHktUnG
        w1r67SPBKd2jWKACnaOgmw==
X-Google-Smtp-Source: ABdhPJw6M53q3mGjQpCyBIOsH6wRcH4MFB1SmVr210gqPgagVaLR+x/IX58B6WE3BVDZBl2RRqJ2OQ==
X-Received: by 2002:a05:6830:118f:: with SMTP id u15mr9119859otq.43.1614971883915;
        Fri, 05 Mar 2021 11:18:03 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm698379oih.34.2021.03.05.11.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:18:03 -0800 (PST)
Received: (nullmailer pid 500223 invoked by uid 1000);
        Fri, 05 Mar 2021 19:18:02 -0000
Date:   Fri, 5 Mar 2021 13:18:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     trix@redhat.com, chinnikishore369@gmail.com,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        mdf@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: Add compatible value for
 Xilinx DFX AXI shutdown manager
Message-ID: <20210305191802.GA500189@robh.at.kernel.org>
References: <20210211051148.16722-1-nava.manne@xilinx.com>
 <20210211051148.16722-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211051148.16722-2-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 11 Feb 2021 10:41:47 +0530, Nava kishore Manne wrote:
> This patch Adds compatible value for Xilinx Dynamic Function eXchnage(DFX)
> AXI Shutdown manager IP.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Modified the doc and added DFX axi shutdown manager node
>                  example node as suggested by Tom Rix.
> 
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
