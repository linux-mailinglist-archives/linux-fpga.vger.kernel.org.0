Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479D31E10A
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Feb 2021 22:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhBQVHi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Feb 2021 16:07:38 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:41650 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhBQVHh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Feb 2021 16:07:37 -0500
Received: by mail-oo1-f47.google.com with SMTP id h38so3394526ooi.8;
        Wed, 17 Feb 2021 13:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQwMs3U/95KY+I7ERg8afjmtvvQ8j6QtTF7kUMzLV2M=;
        b=Xjc4nfv4WlgVJaENohief3mL6BTibw4hVugHlPXqxG94fdT0LyZ0KyfuOmYfmqC6te
         u3K+h6tOoipBxsMWR4EFT1uTXgnOP4C5yQU1xIg2cKLstF8eiN+I6VcA7A/k7Le1du3t
         FMJe9C6DXs6k9bvMEp8/DEyI1eT862qObfbKJeF4irXjOqzK1tpFtZkGzi2dqgXKMjU+
         RgQlOZnRfM7TLt/yYnPy+X/UdZwCk4sR88gdZSpiAe+EoLxZ/w1htg6xKnP8DFRBids1
         WJMBUwz9OL3DdGGt1pyHVGImoN1UnmxdhPQXe6ulPXbFV5UkUlCdlTIN/wediTZ6PJ2l
         qqMg==
X-Gm-Message-State: AOAM533AuzYLDkuzMFMxwBx+74EOddvi1JB1myBbJflGcCUipKswXagg
        dRDD4AwATYC/BPoXTBXxOg==
X-Google-Smtp-Source: ABdhPJyYBIFwNq4dbzmcj6krkSueeChW11Sp3wHQ9o9KLb/3qxt5qOqTk8DmnMZu4ifCffDXyWoeFw==
X-Received: by 2002:a4a:b509:: with SMTP id r9mr683682ooo.21.1613596015798;
        Wed, 17 Feb 2021 13:06:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a28sm618420ook.24.2021.02.17.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:06:54 -0800 (PST)
Received: (nullmailer pid 2756132 invoked by uid 1000);
        Wed, 17 Feb 2021 21:06:53 -0000
Date:   Wed, 17 Feb 2021 15:06:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal
 fpga manager
Message-ID: <20210217210653.GA2752472@robh.at.kernel.org>
References: <20210211060532.23662-1-nava.manne@xilinx.com>
 <20210211060532.23662-3-nava.manne@xilinx.com>
 <1613055380.699799.519684.nullmailer@robh.at.kernel.org>
 <MWHPR02MB2623787A36B389BCF337D8EBC28B9@MWHPR02MB2623.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR02MB2623787A36B389BCF337D8EBC28B9@MWHPR02MB2623.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 12, 2021 at 06:13:33AM +0000, Nava kishore Manne wrote:
> Hi Rob,
> 
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Thursday, February 11, 2021 8:26 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: linux-arm-kernel@lists.infradead.org; mdf@kernel.org; linux-
> > fpga@vger.kernel.org; git <git@xilinx.com>; Appana Durga Kedareswara Rao
> > <appanad@xilinx.com>; devicetree@vger.kernel.org; robh+dt@kernel.org;
> > chinnikishore369@gmail.com; linux-kernel@vger.kernel.org;
> > trix@redhat.com; Michal Simek <michals@xilinx.com>
> > Subject: Re: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal fpga
> > manager
> > 
> > On Thu, 11 Feb 2021 11:35:31 +0530, Nava kishore Manne wrote:
> > > From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> > >
> > > This patch adds binding doc for versal fpga manager driver.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > Signed-off-by: Appana Durga Kedareswara rao
> > > <appana.durga.rao@xilinx.com>
> > > ---
> > > Changes for v2:
> > >                 -Fixed file format and syntax issues.
> > >
> > >  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> > >
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:12:14:
> > [warning] too many spaces after colon (colons)
> > ./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:20:9:
> > [warning] wrong indentation: expected 10 but found 8 (indentation)
> > 
> > dtschema/dtc warnings/errors:
> > 
> > See https://patchwork.ozlabs.org/patch/1439305
> > 
> > This check can fail if there are any dependencies. The base for a patch series
> > is generally the most recent rc1.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above error(s),
> > then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> > 
> > Please check and re-submit.
> 
> Initially, I couldn't see any issue when I run.
> After installing yamllint and with upgraded dt-schema, I am able to reproduce the above pointed issues.
> Is there any prerequisite(Other than yamllint) I need to follow to run dt-schema?

No, just keeping dtschema up to date.

Rob
