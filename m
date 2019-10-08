Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C759D01ED
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Oct 2019 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfJHULd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Oct 2019 16:11:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfJHULd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Oct 2019 16:11:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so10261pfn.11;
        Tue, 08 Oct 2019 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7/9EcLsPyHN5M72vM2Dh9qj2UUt/pHcyAO/sxUa10I=;
        b=VrflBTGGJuMfi+AgBa2OXFiTljpwLdGgJ3mkExMcjdlSMkxCYrfhBZUR6FTOkETadu
         9tUcj20xtj3BppPJHt2SWTNbMaLGlHyBhsy2phIUGg86seUtYHfkl0dhVuYtOxhWIUJ+
         AH62SVPuRfkZpFG2rMWS4jz6FzsX4zf+kPny7umo2Ivo6XxIK69kp1hBTQKGnoLIlR/P
         Klf2MZqxNS//RuDsWNAenA2f0ljIZra60DOBC+AJU12vf29aLO8hXa58rkNQ+sDxsGFg
         q6ViPUxqyIm87M85qyFD90UAJKiCcSWSjc07ezoOw9bkMhwALzGa+4afr80gKvimiIAn
         UQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7/9EcLsPyHN5M72vM2Dh9qj2UUt/pHcyAO/sxUa10I=;
        b=QfMt3bDA0pBUnJ08MczG9XPTudtlWHu1Ir+e1vWYS3Hi9J/HSdblN6gOkK4hqXbwYz
         gi3ATgVoN4eSHWR1Cmc1AcsQoTSMFgoWZqt4idJIrVqHYzcwyDt8d/Y9VKacYTWjw9Qr
         /JBnvtiSD6cYSDlMrYbtiY8nxxjW4LKO2DHo1/sCUVrtwV3glt31AWOR/YBAc8eZNZXX
         MlHW0Ji2I2aZKjQfSkyGB6nZwpLqxWIYWeKxS6dbdQ8PAY4SMTrJPEKzQYRQCk4JUqqy
         uggMrglaUqbhFUz2Epq0LVZlY5Xxw0SS18Xiw7Q346SrU2ZzpZq7EjL6xzWYVbpSNP6W
         7Raw==
X-Gm-Message-State: APjAAAWetXQ8Cg43/0k+BTpaQ/Bf9yQ5QvKgo/xd65ZhNhOCp3I2cKO6
        +MRHJ1eeCKSj5gWmtHjyoj8=
X-Google-Smtp-Source: APXvYqwqnXcAH8nYSgH3S93JmJb6c8Zk75A9uekNBUOFBLGg4iem0oxdgrDzgqrnwuU0XEOetqwYsw==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr6319739pfi.252.1570565492415;
        Tue, 08 Oct 2019 13:11:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c64sm337pfc.19.2019.10.08.13.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 13:11:30 -0700 (PDT)
Date:   Tue, 8 Oct 2019 13:11:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] hwmon: Support ADI Fan Control IP
Message-ID: <20191008201129.GA14652@roeck-us.net>
References: <20190926103925.194973-1-nuno.sa@analog.com>
 <20190926103925.194973-3-nuno.sa@analog.com>
 <20191006153209.GA30372@roeck-us.net>
 <1125a1f831a76b27ccc050a0db4499e5c4abd76c.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125a1f831a76b27ccc050a0db4499e5c4abd76c.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 08, 2019 at 03:59:49PM +0000, Sa, Nuno wrote:
[ ... ]
> > > +
> > > +	ctl->irq = platform_get_irq(pdev, 0);
> > > +	if (ctl->irq < 0) {
> > 
> > This can return -EPROBE_DEFER. On top of that, it already generates
> > an error
> > message, meaning another one here is unnecessary.
> 
> Why returning -EPROBE_DEFER? platform_get_irq() already seems to handle
> EPROBE_DEFER...
> 
... which is exactly why I am saying that you don't need another error
message, and that an unconditional error message is a bad idea.

Guenter
