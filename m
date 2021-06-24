Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B773B37C7
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhFXU3e (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 16:29:34 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:39826 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXU3d (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Jun 2021 16:29:33 -0400
Received: by mail-il1-f176.google.com with SMTP id o10so2726906ils.6;
        Thu, 24 Jun 2021 13:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=npEvBzqWXV+Ap1xRJe1V/33AQ6ZdvCYpQoT/xt+Fgqs=;
        b=sojDaJuj2ysPybcGekm8JBE0h/Y1UOHvPb6hglhcxOYIn/SuLfYTPRsPAralFtTwds
         /oRvAYP1ghAfVOUFZplFNXz7cysixHc167mG+MP6BLDfGfjmFDDfCTTsPXuyY0NaFXiy
         TniK6oKThn2LjP0ZhzQBdwtdr9ZtbeL6JBlzVvP8Lrv0ZmE5Mf7S049s36LMiVKccPcc
         3LpSCsY99Mh7Adc6cvU/fVjodYnBI7uMRd8UYssjE90OVIEByAp462J34A2ohBlcFdTF
         Nd6lGfivJe9fxPgXE8oaCP0O8wt1lHZtZ3CsxqT/aCLcMUhUB90hRBt4ZXm6bs6UF60M
         MDbg==
X-Gm-Message-State: AOAM532WPl3NJaWETHWROHDfVl8YEcRrskapbagfZY7JShao1B109rPO
        DsoGArVywP9uELjudpLufw==
X-Google-Smtp-Source: ABdhPJwcp05Yzz/YmFvVrUPUSpwi6jXXyyQKOxvq4ebEoIIK46HKLZLMRdubVMPV6m/+H0cUQPq35Q==
X-Received: by 2002:a05:6e02:12ee:: with SMTP id l14mr4872957iln.59.1624566434002;
        Thu, 24 Jun 2021 13:27:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z3sm1959287ior.14.2021.06.24.13.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:27:13 -0700 (PDT)
Received: (nullmailer pid 1933406 invoked by uid 1000);
        Thu, 24 Jun 2021 20:27:09 -0000
Date:   Thu, 24 Jun 2021 14:27:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     michal.simek@xilinx.com, trix@redhat.com,
        linux-arm-kernel@lists.infradead.org, moritz.fischer@ettus.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: zynq: convert bindings to YAML
Message-ID: <20210624202709.GA1933372@robh.at.kernel.org>
References: <20210613212856.296153-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613212856.296153-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 14 Jun 2021 06:28:56 +0900, Nobuhiro Iwamatsu wrote:
> Convert FPGA for Xilinx Zynq SoC bindings documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../bindings/fpga/xilinx-zynq-fpga-mgr.txt    | 19 -------
>  .../bindings/fpga/xilinx-zynq-fpga-mgr.yaml   | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
> 

Applied, thanks!
