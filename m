Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64F53A05ED
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhFHV0m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 17:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234389AbhFHV0X (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 17:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeq8qRfoRfsbx4uL9oOz0deeKscRGraAzU6rnmI4bDk=;
        b=GxkaqM3Cf+lORjEVs/ycRRWiFqkfHKDfiF027LswJI54lBhfsj9NQQp0nPa5Hhl65RpmWN
        cR9KrXaOP/SKWKah1STX8lHUud8rWUeLeTWbLroeY82ldBkwDawx6fcrCcnQpsrHaqx7FH
        3WKPf69/+eu94o78xVJdUcTodhPMjTo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-G7pn8fWHPXinNt3sMfirBQ-1; Tue, 08 Jun 2021 17:24:28 -0400
X-MC-Unique: G7pn8fWHPXinNt3sMfirBQ-1
Received: by mail-ot1-f72.google.com with SMTP id 88-20020a9d06e10000b029030513a66c79so14819936otx.0
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 14:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jeq8qRfoRfsbx4uL9oOz0deeKscRGraAzU6rnmI4bDk=;
        b=tuF8p9S6ygysofbTiEIwpMD3WdH4eW20dkNQxQpzg344dI5Y2J/3CP1t+iSFTcE6I9
         1mLkSl865J6DY4YIlPj+D5IqaMdz1NC3Y4CaEitv9vaOORNgQRrFLKxUFSlR2ONCQRVA
         ovIdCf+LtEkOz0GO7EO0A6VFb3etQ8hXb7IqSrnPFaev/XtqeOHyQbspOftuE4RcDTfK
         AlIq72ygryVnXahz+sfUsgjofgyVZaPfkFUgsEBY3e0rbMsQqDTVyFaXt4wkdMtKLITI
         uC6R9uK/6RyzFV4Sw3xlzmlE/TB4P1ScBJekfgqXsllGzlJBtPS/6lBA3WHv9NF7b07g
         2REA==
X-Gm-Message-State: AOAM530oRaV2uQEc0zoQ8f1HUTuySJK5mDuKscN1JcbNUyxCiRS1ioiD
        cIt4L/4gEhEJNkSOrcenTz9P7bpbGE+OZC0a8skDHzxUsDz4g1Spx/FMaIdBfERJbwuWl3bBHD8
        LnMGDs0crYV9Uq39ncl4Q6Q==
X-Received: by 2002:a05:6830:1309:: with SMTP id p9mr12963261otq.209.1623187468230;
        Tue, 08 Jun 2021 14:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKsGI5o2pAZuxgtMx6UsQ5GpgFuru3G9QqB8VKcT3CwJSpYN5gRSP28hE4xYJAJAJCEsUFOQ==
X-Received: by 2002:a05:6830:1309:: with SMTP id p9mr12963250otq.209.1623187468089;
        Tue, 08 Jun 2021 14:24:28 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:27 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 11/11] staging: fpgaboot: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:50 -0700
Message-Id: <20210608212350.3029742-13-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/gs_fpgaboot/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gs_fpgaboot/README b/drivers/staging/gs_fpgaboot/README
index b85a76849fc4a..ec1235a21bcc1 100644
--- a/drivers/staging/gs_fpgaboot/README
+++ b/drivers/staging/gs_fpgaboot/README
@@ -39,7 +39,7 @@ TABLE OF CONTENTS.
 
 5. USE CASE (from a mailing list discussion with Greg)
 
-	a. As a FPGA development support tool,
+	a. As an FPGA development support tool,
 	During FPGA firmware development, you need to download a new FPGA
 	image frequently.
 	You would do that with a dedicated JTAG, which usually a limited
-- 
2.26.3

