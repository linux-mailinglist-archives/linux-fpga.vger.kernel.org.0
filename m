Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86993183AB4
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Mar 2020 21:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCLUif (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Mar 2020 16:38:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41800 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUif (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Mar 2020 16:38:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id s15so7753121otq.8;
        Thu, 12 Mar 2020 13:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsyf53fDOW2kIfBB6h9PfXR888dEi0c9UB48kNqadU0=;
        b=QPB6LM82y2odDnTq56W6yLN1rE16wNdbqX6RsAkrEd3pYcP0/bzpjowgedpPA0ncpA
         pdM5woVUK6XLDPasFI5QP9RWbKOQZeGr/oqGLTwq+8wC26h55WNMWXf2BhtE5USf/fcv
         zwu8D/+y1l4uAZ0IG65k2GkkgO7JDVpdSCRQ3H8fHPdkA9pP0aKhMwStxTy1PEfzHPPL
         nC4YZhCdPkJ87i4ZB5p89lFrISv2NvVCBblC03SLHKXQAGns1QAoP5X627z+ei9xmzV5
         jughoKTwZlnrQVHu4pxJmUM5nQcwbUoif14ruyMNQUgvtGIctTglKVN5BHisNloQEN20
         6SBg==
X-Gm-Message-State: ANhLgQ0TCWfjGHFKAsOFKTO8hx9G5YsaxSQSNTItuXTGQRr6dABSK6GD
        ImP8qtz7bz7H3ZH0T4UlbQ==
X-Google-Smtp-Source: ADFU+vtjBZJYB7cBB6cNsWPMGuK7UPYILgJCWYhGg99znHQiTnDlaIOyzFbSRtAcjckQTwHpwGhpCA==
X-Received: by 2002:a9d:b8f:: with SMTP id 15mr7962990oth.256.1584045514482;
        Thu, 12 Mar 2020 13:38:34 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u205sm7065396oia.37.2020.03.12.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:38:33 -0700 (PDT)
Received: (nullmailer pid 31724 invoked by uid 1000);
        Thu, 12 Mar 2020 20:38:31 -0000
Date:   Thu, 12 Mar 2020 15:38:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        ley.foon.tan@intel.com, robh+dt@kernel.org, mdf@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/2] arch: nios2: rename 'altr,gpio-bank-width' ->
 'altr,ngpio'
Message-ID: <20200312203831.GA31683@bogus>
References: <20200306115450.3352-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306115450.3352-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 6 Mar 2020 13:54:49 +0200, Alexandru Ardelean wrote:
> There is no more 'altr,gpio-bank-width' in the 'altr,pio-1.0' driver.
> There is a 'altr,ngpio' which is  what the property wants to configure.
> 
> This change updates all occurrences of 'altr,gpio-bank-width' to
> 'altr,ngpio'.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++--
>  arch/nios2/boot/dts/10m50_devboard.dts                 | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
