Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF1399299
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Jun 2021 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFBSeL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Jun 2021 14:34:11 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:47040 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhFBSeK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Jun 2021 14:34:10 -0400
Received: by mail-oi1-f171.google.com with SMTP id x15so3558456oic.13;
        Wed, 02 Jun 2021 11:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hCqTrOn+AB8J/ZYPKhnhDqNUe6g4nA/fipGWwsGP4PY=;
        b=T0qXw4CcJJe33M3crkONuPqcRfAgK+1Sq9sUJ7oK9qN9UN/xGFUxgw6NdiXC2lxav6
         7T3+BFhcey171b1RWaZci9C21lQ2IiCcMKukhNeOOafhUMER26cfRoWuw0jHtZKZ5z0L
         biBkVmJ6/zxAdFMYZxymTszn1npPyqfXBl2+eMIyT0oTHPpJfd7Ygx9MnErstasMlmpl
         e/8flEVntRl7iO2NsGorrfc3e/hc5rbIPMLkDlMgtTV0QaYYxC8ewWEhn/PnxOfAj1xG
         fm/Xba/PBL61bbCahgoCveaI+9UHLgqnsLm/wI0Z+y9+othE4e0VaX4m3sPOG2tfM4cQ
         QZmg==
X-Gm-Message-State: AOAM530ZAKBKM5+lEBO+FuTDHVyWme00SVvZ4zvFbrZKbfelbIXQzWmu
        fjNIvYPgMvJzMn0f82nqPFx3UA87lA==
X-Google-Smtp-Source: ABdhPJzRAVxVl6cfhH69D4gC0mt9+iv2cH3EyCBvPqUnrK1WDRNdNyslnzimBv3AQs8IxANOPxdH4w==
X-Received: by 2002:a05:6808:138e:: with SMTP id c14mr23320942oiw.55.1622658729875;
        Wed, 02 Jun 2021 11:32:09 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b6sm139334oic.12.2021.06.02.11.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:32:09 -0700 (PDT)
Received: (nullmailer pid 3731322 invoked by uid 1000);
        Wed, 02 Jun 2021 18:32:07 -0000
Date:   Wed, 2 Jun 2021 13:32:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     chinnikishore369@gmail.com, mdf@kernel.org, trix@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iwamatsu@nigauri.org, arnd@arndb.de,
        zou_wei@huawei.com, michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        ravi.patel@xilinx.com, linux-fpga@vger.kernel.org,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        amit.sunil.dhamne@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, tejas.patel@xilinx.com,
        git@xilinx.com, linux-arm-kernel@lists.infradead.org,
        wendy.liang@xilinx.com, robh+dt@kernel.org
Subject: Re: [PATCH v6 2/4] dt-bindings: fpga: Add binding doc for versal
 fpga manager
Message-ID: <20210602183207.GA3731262@robh.at.kernel.org>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
 <20210520080954.1393-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520080954.1393-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 20 May 2021 13:39:52 +0530, Nava kishore Manne wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> This patch adds binding doc for versal fpga manager driver.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> Changes for v2:
>                 -Fixed file format and syntax issues.
> Changes for v3:
>                 -Removed unwated extra spaces.
> Changes for v4:
>                 -Rebased the changes on linux-next.
>                  No functional changes
> Changes for v5:
>                 -Updated fpga node name to versal_fpga.
> 
> Changes for v6:
>                -None.
> 
>  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
