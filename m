Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58113A05C5
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhFHV0K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 17:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234304AbhFHV0H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 17:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp596HvsXKCpAwusArsHwfjreuet0FT2ap8ASM9VttM=;
        b=TFlPNDMjf+cHohtSQI0/ectI6u99+m29yOM1BwoID2JD+SKcYFGbXh+WpDVLgr1Kzh08q9
        S5sUUne9RkJ1Jazy5V+1zWxcOGx2rFdAW2enDfRH6Tn7+oCG1fx15dL4OQ36W4VGe+PCCA
        s+aR1K6JCkhoBxqyzkLAjF+HBsl47Bw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-nzFVUH5qMqqhyFyaGCB1sA-1; Tue, 08 Jun 2021 17:24:12 -0400
X-MC-Unique: nzFVUH5qMqqhyFyaGCB1sA-1
Received: by mail-ot1-f72.google.com with SMTP id y2-20020a0568301082b02903b5696f0a64so14808983oto.2
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 14:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wp596HvsXKCpAwusArsHwfjreuet0FT2ap8ASM9VttM=;
        b=lIT5afI5YvuO31paBTA2xxafwnnayRejXtHfAL5pNhePwk14UAOQZM6jhDXPODZiG1
         OWjlrtV3Bo6ALeDRxpJWDjqjsfNKMHzk9v7MppOyWqRcVfNBrUsjFz7envV7TrE/1gcs
         IsGKmAdKVgqQTuhn9xS1KbSSHPxzr7nT9qy42ML2rWvApx2qjvKNFQqaSgUoe615OGdW
         ON4AeTwuN9nR2gCiDQ5AzUz+G0tns1tQjmD6ZMMc6GqAs3yvnRYz3sVsf8wdYUpeCzYW
         6XBXpzYU+QEbQZZqhwH3m5KdsGsYOGRhEfpOnY8oEkWmkOTjYyroq7/hH9rT039+dYOe
         mw0w==
X-Gm-Message-State: AOAM531d8hVCl1QKFSOwKne0+mePn0wRUMg9SsQM/oqVQECLLR8i8PDr
        4xtt9iM4jELseCc6BOZ/E2GF6FGSCUGVzvTrhUCJ92lTIE5Ol1IEvxMA2n2RrJdS1rNP5QGlu8d
        Nnl3vxAFJMHo+ThJOEPrXUA==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr12732178otr.62.1623187451514;
        Tue, 08 Jun 2021 14:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLOwO0hiMF+KA6dMHmw2cY7cTlxB9WKoQb/W2MRs5OG0rKOt4HtiG8bWLvQUw/6wISGO0yyQ==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr12732164otr.62.1623187451344;
        Tue, 08 Jun 2021 14:24:11 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:11 -0700 (PDT)
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
Subject: [PATCH 04/11] crypto: marvell: cesa: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:43 -0700
Message-Id: <20210608212350.3029742-6-trix@redhat.com>
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
 drivers/crypto/marvell/cesa/cesa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.h b/drivers/crypto/marvell/cesa/cesa.h
index c1007f2ba79c8..d215a6bed6bc7 100644
--- a/drivers/crypto/marvell/cesa/cesa.h
+++ b/drivers/crypto/marvell/cesa/cesa.h
@@ -66,7 +66,7 @@
 #define CESA_SA_ST_ACT_1			BIT(1)
 
 /*
- * CESA_SA_FPGA_INT_STATUS looks like a FPGA leftover and is documented only
+ * CESA_SA_FPGA_INT_STATUS looks like an FPGA leftover and is documented only
  * in Errata 4.12. It looks like that it was part of an IRQ-controller in FPGA
  * and someone forgot to remove  it while switching to the core and moving to
  * CESA_SA_INT_STATUS.
-- 
2.26.3

