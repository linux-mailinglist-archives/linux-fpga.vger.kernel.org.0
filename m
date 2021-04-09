Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DEC35A17D
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhDIOvJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 10:51:09 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44902 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDIOvJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Apr 2021 10:51:09 -0400
Received: by mail-oi1-f174.google.com with SMTP id a8so6002612oic.11;
        Fri, 09 Apr 2021 07:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8lql2yy1y8vXrMPwHnqaBCLZA9iwFnMAhgR5EhNRjU=;
        b=W0DaIcKLrge8NZvfqAsS1Lzv0bFgoRu8NcyifsOWYc+Cm/8q5oeJ8epEzzHCU1LKZl
         b5vnZJaX5t0u86LOGmld6s/YbZFd19po/mM+PB8JH3k08rZD3DuijxsBVkB8UMUOFo9s
         ISVdVpnB9w84tZPEOj0aLSkDmsUNNXC3nrlz/8AmB0JGsrUoje4wFN+984bmoubMAP5p
         zWToPmblYGoijmBiAbwF+LTNMfH5NW6PsU+JAiNhp5QC72Wu4npWi0dJ8kVEcZxNbjwQ
         gBytIMj6UKiMY+nO9usR8yct7y9Oi2nj4Ra0M3U4U3r/gBWoBTYnaR6gqrQDCxvN8k+q
         KovA==
X-Gm-Message-State: AOAM531fTdfLgLv0a2sc/nusATOFn+srSNK9n8t3NtwWxi0cDWejAwWH
        ZLURDeTSJd81KUszUwsAHw==
X-Google-Smtp-Source: ABdhPJw98mImVWp3e5bSssvSjNoT5Ywf6ZG7Ty+hjYQgkxvpYYb2kkMStqzvrqKb4KjoKRYWax1/Sg==
X-Received: by 2002:aca:1702:: with SMTP id j2mr10301038oii.165.1617979855764;
        Fri, 09 Apr 2021 07:50:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v195sm557430oia.38.2021.04.09.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:50:55 -0700 (PDT)
Received: (nullmailer pid 3632568 invoked by uid 1000);
        Fri, 09 Apr 2021 14:50:53 -0000
Date:   Fri, 9 Apr 2021 09:50:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org,
        michal.simek@xilinx.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] fpga: region: Add fpga-region property
 'power-domains'
Message-ID: <20210409145053.GA3632538@robh.at.kernel.org>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092049.479-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 02 Apr 2021 14:50:48 +0530, Nava kishore Manne wrote:
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

Acked-by: Rob Herring <robh@kernel.org>
